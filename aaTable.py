# Draw nested 2×2 codon visualization from a TSV AA table (codon<TAB>AA)
# Orientation fixed to the small-square convention: top row A T; bottom row G C.
# By default, only lines that divide amino acids are shown.

from typing import Dict, Optional, Tuple, List
import math
import csv
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle, Circle, FancyArrow
from matplotlib.colors import Normalize
import matplotlib.cm as cm
from sys import argv

script, outf, table = argv

NUCLEOTIDES = ["A","T","G","C"]

# --- Layout helpers ---
# (A T) / (G C) layout across all nesting levels

def nt_pos_2x2(nt: str) -> Tuple[int,int]:
	if nt == "A":
		return (0,0)
	elif nt == "T":
		return (1,0)
	elif nt == "G":
		return (0,1)
	elif nt == "C":
		return (1,1)
	else:
		raise ValueError(f"Unknown nucleotide: {nt}")

# --- IO ---

def read_aa_table_tsv(path: str) -> Dict[str,str]:
	"""Read a simple TSV with lines: codon	aa
	Header is optional. Codons and AA labels are uppercased; whitespace trimmed.
	Stop can be labeled as 'X' or 'STOP'.
	"""
	mapping: Dict[str,str] = {}
	with open(path, newline='') as f:
		reader = csv.reader(f, delimiter='	')
		for row in reader:
			if not row or len(row) < 2:
				continue
			codon = row[0].strip().upper()
			aa = row[1].strip().upper()
			if codon == 'CODON' and aa in ('AA','AMINOACID','AMINO_ACID'):
				# header line
				continue
			if aa == 'STOP':
				aa = 'X'
			mapping[codon] = aa
	# Basic sanity
	missing = [c for c in (a+b+d for a in NUCLEOTIDES for b in NUCLEOTIDES for d in NUCLEOTIDES) if c not in mapping]
	if missing:
		raise ValueError(f"AA table missing {len(missing)} codons (e.g., {missing[:5]} ...)")
	return mapping

# --- Core drawing ---

def draw_codon_grid(
	aa_map: Dict[str,str],
	data_by_codon: Optional[Dict[str,float]] = None,
	outfile: Optional[str] = None,
	figsize: Tuple[float,float] = (8,8),
	pad: float = 0.4,
	linewidth: float = 1.6,
	font_size_aa: float = 14,
	font_size_codon_value: float = 9,
	only_dividing_lines: bool = True,
	show_cpg_circles: bool = True,
	show_bridge_arrows: bool = True,
	cmap_name: str = 'magma',
) -> plt.Figure:
	"""Draw nested 2×2 grid with AA labels from aa_map.

	only_dividing_lines=True ⇒ draw interior lines only when the two sides encode different AA sets.
	show_cpg_circles ⇒ large circle for CGX (pos1-2=CG); small circles for NCG (pos2-3=CG).
	show_bridge_arrows ⇒ long diagonal left arrows in each P1='G' box (four codons that bridge 'left');
	and small right arrows in each codon with P3='C'.
	"""
	fig, ax = plt.subplots(figsize=figsize)
	ax.set_aspect('equal')
	ax.axis('off')

	W, H = 8.0, 8.0
	OX, OY = pad, pad

	def rect_for_nt(origin: Tuple[float,float], size: Tuple[float,float], nt: str) -> Tuple[float,float,float,float]:
		col,row = nt_pos_2x2(nt)
		w,h = size
		x = origin[0] + col * (w/2)
		y = origin[1] + row * (h/2)
		return (x,y,w/2,h/2)

	# Colormap for data
	cmap = cm.get_cmap(cmap_name)
	norm = None
	if data_by_codon:
		vals = [v for v in data_by_codon.values() if v is not None and not math.isnan(v)]
		norm = Normalize(vmin=min(vals) if vals else 0, vmax=max(vals) if vals else 1)

	# --- Helper to collect AA sets in regions ---
	def aa_set_in_region(p1s: List[str], p2s: List[str], p3s: List[str]) -> set:
		return set(aa_map[f"{p1}{p2}{p3}"] for p1 in p1s for p2 in p2s for p3 in p3s)

	# --- Outer border and optional P2 midlines ---
	ax.add_patch(Rectangle((OX, OY), W, H, fill=False, lw=linewidth*1.2))

	# Decide P2 vertical line (between {A,G} and {T,C})
	left_AA = aa_set_in_region(["A","G"], NUCLEOTIDES, NUCLEOTIDES)
	right_AA = aa_set_in_region(["T","C"], NUCLEOTIDES, NUCLEOTIDES)
	if (not only_dividing_lines) or (left_AA != right_AA):
		ax.plot([OX + W/2, OX + W/2], [OY, OY + H], color='black', lw=linewidth)

	# Decide P2 horizontal line (between {A,T} and {G,C})
	top_AA = aa_set_in_region(["A","T"], NUCLEOTIDES, NUCLEOTIDES)
	bottom_AA = aa_set_in_region(["G","C"], NUCLEOTIDES, NUCLEOTIDES)
	if (not only_dividing_lines) or (top_AA != bottom_AA):
		ax.plot([OX, OX + W], [OY + H/2, OY + H/2], color='black', lw=linewidth)

	# Iterate quadrants (P2)
	for p2 in NUCLEOTIDES:
		qx,qy,qw,qh = rect_for_nt((OX,OY),(W,H), p2)
		# Border of quadrant (always subtle)
		ax.add_patch(Rectangle((qx,qy), qw, qh, fill=False, lw=linewidth*0.6, edgecolor='black'))

		# Decide P1 midlines in this quadrant
		# Vertical: left {A,G} vs right {T,C} within this p2
		leftAA = aa_set_in_region(["A","G"], [p2], NUCLEOTIDES)
		rightAA = aa_set_in_region(["T","C"], [p2], NUCLEOTIDES)
		if (not only_dividing_lines) or (leftAA != rightAA):
			ax.plot([qx + qw/2, qx + qw/2], [qy, qy + qh], color='black', lw=linewidth*0.8)
		# Horizontal: top {A,T} vs bottom {G,C} within this p2
		topAA = aa_set_in_region(["A","T"], [p2], NUCLEOTIDES)
		bottomAA = aa_set_in_region(["G","C"], [p2], NUCLEOTIDES)
		if (not only_dividing_lines) or (topAA != bottomAA):
			ax.plot([qx, qx + qw], [qy + qh/2, qy + qh/2], color='black', lw=linewidth*0.8)

		for p1 in NUCLEOTIDES:
			p1x,p1y,p1w,p1h = rect_for_nt((qx,qy),(qw,qh), p1)
			# Border for P1 box subtle
			ax.add_patch(Rectangle((p1x,p1y), p1w, p1h, fill=False, lw=linewidth*0.5, edgecolor='black'))

			# Determine AA set across P3
			aa_set = {aa_map[f"{p1}{p2}{p3}"] for p3 in NUCLEOTIDES}
			show_p3 = len(aa_set) != 1  # only draw P3 when it divides AAs

			if show_p3:
				# Decide P3 midlines in this P1 box
				# Vertical: left {A,G} vs right {T,C} at P3
				leftP3_AA = {aa_map[f"{p1}{p2}{p3}"] for p3 in ("A","G")}
				rightP3_AA = {aa_map[f"{p1}{p2}{p3}"] for p3 in ("T","C")}
				if (not only_dividing_lines) or (leftP3_AA != rightP3_AA):
					ax.plot([p1x + p1w/2, p1x + p1w/2], [p1y, p1y + p1h], color='black', lw=linewidth*0.7)
				# Horizontal: top {A,T} vs bottom {G,C} at P3
				topP3_AA = {aa_map[f"{p1}{p2}{p3}"] for p3 in ("A","T")}
				bottomP3_AA = {aa_map[f"{p1}{p2}{p3}"] for p3 in ("G","C")}
				if (not only_dividing_lines) or (topP3_AA != bottomP3_AA):
					ax.plot([p1x, p1x + p1w], [p1y + p1h/2, p1y + p1h/2], color='black', lw=linewidth*0.7)

				for p3 in NUCLEOTIDES:
					c3x,c3y,c3w,c3h = rect_for_nt((p1x,p1y),(p1w,p1h), p3)
					codon = f"{p1}{p2}{p3}"
					aa = aa_map[codon]

					# Fill light grey to distinguish cells (optional)
					ax.add_patch(Rectangle((c3x,c3y), c3w, c3h, facecolor='#f8f8f8', edgecolor='black', lw=linewidth*0.3))
					ax.text(c3x + c3w/2, c3y + c3h/2, aa, ha='center', va='center', fontsize=font_size_aa, fontweight='bold')

					# Data overlay
					if data_by_codon and (codon in data_by_codon) and (data_by_codon[codon] is not None):
						v = data_by_codon[codon]
						cv = cmap(Normalize(vmin=min(data_by_codon.values()), vmax=max(data_by_codon.values()))(v))
						m = min(c3w, c3h) * 0.15
						ax.add_patch(Rectangle((c3x+m, c3y+m), c3w-2*m, c3h-2*m, facecolor=cv, edgecolor=None))
						ax.text(c3x + c3w/2, c3y + c3h/2, f"{v:.2f}", ha='center', va='center', fontsize=font_size_codon_value)

					# CpG small circle for NCG (pos2-3 = CG)
					if show_cpg_circles and p2 == 'C' and p3 == 'G':
						cx = c3x + c3w/2; cy = c3y + c3h/2
						r = min(c3w, c3h) * 0.42
						ax.add_patch(Circle((cx, cy), radius=r, fill=False, lw=linewidth*0.8, color='#444'))
					# Small forward arrow for P3='C'
					if show_bridge_arrows and p3 == 'C':
						ax.add_patch(FancyArrow(c3x + c3w*0.85, c3y + c3h*0.5, c3w*0.1, 0,
							width=0.03, head_width=0.22, head_length=0.12, length_includes_head=True, color='#666'))

			else:
				# Synonymous across P3: single box
				aa = next(iter(aa_set))
				ax.add_patch(Rectangle((p1x,p1y), p1w, p1h, facecolor='#f0f0f0', edgecolor='black', lw=linewidth*0.3))
				ax.text(p1x + p1w/2, p1y + p1h/2, aa, ha='center', va='center', fontsize=font_size_aa, fontweight='bold')

				# Large circle for CGX (pos1-2 = CG)
				if show_cpg_circles and p1 == 'C' and p2 == 'G':
					cx = p1x + p1w/2; cy = p1y + p1h/2
					r = min(p1w, p1h) * 0.48
					ax.add_patch(Circle((cx, cy), radius=r, fill=False, lw=linewidth*1.0, color='#333'))

			# Long diagonal left-facing arrow in P1='G' boxes (four codons bridge left)
			if show_bridge_arrows and p1 == 'G':
				# Arrow direction: left/up for top quadrants; left/down for bottom quadrants
				dx = -p1w * 0.55
				dy = (p2 in ('A','T')) and (p1h * 0.25) or (-p1h * 0.25)
				ax.add_patch(FancyArrow(p1x + p1w*0.85, p1y + p1h*0.5, dx, dy,
					width=0.05, head_width=0.35, head_length=0.18, length_includes_head=True, color='#444'))

	ax.set_title("Nested 2×2 Codon Grid (from TSV) — only dividing lines shown", fontsize=14, pad=12)

	if outfile:
		fig.savefig(outfile, bbox_inches='tight')
	return fig

# Convenience wrapper: read TSV then draw

def draw_codon_grid_from_tsv(tsv_path: str, **kwargs) -> plt.Figure:
	aa_map = read_aa_table_tsv(tsv_path)
	return draw_codon_grid(aa_map, **kwargs)

draw_codon_grid_from_tsv(table, outfile=outf)
