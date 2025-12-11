
# codon_grid_viz_regions.py
# Pastel regional coloring, one label per contiguous block, no dividing lines.
# Reads AA mapping from TSV (codon	aa). Ensures the two Serine blocks share the same color.

from typing import Dict, Optional, Tuple, List
import math
import csv
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle, Circle, FancyArrow

NUCLEOTIDES = ["A","T","G","C"]

# (A T)/(G C) layout

def nt_pos_2x2(nt: str) -> Tuple[int,int]:
	return {"A":(0,0), "T":(1,0), "G":(0,1), "C":(1,1)}[nt]

# Read AA table

def read_aa_table_tsv(path: str) -> Dict[str,str]:
	mapping: Dict[str,str] = {}
	with open(path, newline='') as f:
		reader = csv.reader(f, delimiter='	')
		for row in reader:
			if not row or len(row) < 2:
				continue
			codon = row[0].strip().upper()
			aa = row[1].strip().upper()
			if codon == 'CODON':
				# header
				continue
			if aa == 'STOP':
				aa = 'X'
			mapping[codon] = aa
	# sanity
	all_codons = [a+b+c for a in NUCLEOTIDES for b in NUCLEOTIDES for c in NUCLEOTIDES]
	missing = [c for c in all_codons if c not in mapping]
	if missing:
		raise ValueError(f"AA table incomplete; missing {len(missing)} codons (e.g., {missing[:6]})")
	return mapping

# Compute rectangles for P2, P1, P3 levels

def rect_for_nt(origin: Tuple[float,float], size: Tuple[float,float], nt: str) -> Tuple[float,float,float,float]:
	col,row = nt_pos_2x2(nt)
	w,h = size
	x = origin[0] + col * (w/2)
	y = origin[1] + row * (h/2)
	return (x,y,w/2,h/2)

# Assign pastel colors to amino acids using 5-color palette
# Ensure S has consistent color across its blocks.

def build_aa_color_map(aa_set: List[str]) -> Dict[str,str]:
	palette = [
		"#fde2e4",  # rose
		"#cdeac0",  # mint
		"#c7d3ff",  # periwinkle
		"#fff1b6",  # lemon
		"#e6f7ff",  # powder blue
	]
	# Simple deterministic assignment: bucket by AA category-ish groups (not strict), S fixed to palette[2]
	order = ["X","G","A","V","L","I","M","F","W","Y","C","P","S","T","N","Q","D","E","R","K","H"]
	aa2color: Dict[str,str] = {}
	for i, aa in enumerate(order):
		if aa not in aa_set:
			continue
		if aa == 'S':
			aa2color[aa] = palette[2]
		else:
			aa2color[aa] = palette[i % len(palette)]
	return aa2color

# Core drawing: no interior lines, pastel regions, one label per block

def draw_codon_regions(
	aa_map: Dict[str,str],
	outfile: Optional[str] = None,
	figsize: Tuple[float,float] = (8,8),
	pad: float = 0.4,
	linewidth_outer: float = 1.6,
	font_size_label: float = 16,
	show_cpg_circles: bool = True,
	show_left_bridge_arrows: bool = True,
) -> plt.Figure:
	fig, ax = plt.subplots(figsize=figsize)
	ax.set_aspect('equal')
	ax.axis('off')

	W, H = 8.0, 8.0
	OX, OY = pad, pad

	# Outer border
	ax.add_patch(Rectangle((OX, OY), W, H, fill=False, lw=linewidth_outer, edgecolor='black'))

	# Build AA color map
	aa_set_all = sorted({aa_map[c] for c in (a+b+c for a in NUCLEOTIDES for b in NUCLEOTIDES for c in NUCLEOTIDES)})
	aa_colors = build_aa_color_map(aa_set_all)

	# Collect blocks to label: each block is (AA, [(rects)]) where rects are rectangles composing the block
	blocks: List[Tuple[str, List[Tuple[float,float,float,float]]]] = []

	for p2 in NUCLEOTIDES:
		qx,qy,qw,qh = rect_for_nt((OX,OY),(W,H), p2)
		for p1 in NUCLEOTIDES:
			p1x,p1y,p1w,p1h = rect_for_nt((qx,qy),(qw,qh), p1)
			# Check synonymy across P3
			aas = [aa_map[f"{p1}{p2}{p3}"] for p3 in NUCLEOTIDES]
			if len(set(aas)) == 1:
				aa = aas[0]
				# Region is whole P1 box
				ax.add_patch(Rectangle((p1x,p1y), p1w, p1h, facecolor=aa_colors.get(aa, '#eeeeee'), edgecolor=None))
				blocks.append((aa, [(p1x,p1y,p1w,p1h)]))
				# CGX circle (positions 1–2 = CG)
				if show_cpg_circles and p1 == 'C' and p2 == 'G':
					cx = p1x + p1w/2; cy = p1y + p1h/2
					ax.add_patch(Circle((cx, cy), radius=min(p1w,p1h)*0.48, fill=False, lw=1.0, color='#333'))
			else:
				# Non-synonymous: subcells are individual blocks by AA
				for p3 in NUCLEOTIDES:
					c3x,c3y,c3w,c3h = rect_for_nt((p1x,p1y),(p1w,p1h), p3)
					codon = f"{p1}{p2}{p3}"
					aa = aa_map[codon]
					ax.add_patch(Rectangle((c3x,c3y), c3w, c3h, facecolor=aa_colors.get(aa, '#eeeeee'), edgecolor=None))
					blocks.append((aa, [(c3x,c3y,c3w,c3h)]))
					# NCG circle (positions 2–3 = CG)
					if show_cpg_circles and p2 == 'C' and p3 == 'G':
						cx = c3x + c3w/2; cy = c3y + c3h/2
						ax.add_patch(Circle((cx, cy), radius=min(c3w,c3h)*0.42, fill=False, lw=1.0, color='#444'))

			# Long diagonal left-facing arrow for P1='G' boxes
			if show_left_bridge_arrows and p1 == 'G':
				# start near right edge, middle; end left/up if top half, left/down if bottom half
				start_x = p1x + p1w*0.92
				start_y = p1y + p1h*0.50
				end_x   = p1x + p1w*0.10
				end_y   = p1y + (p1h*0.15 if p2 in ('A','T') else p1h*0.85)
				dx = end_x - start_x
				dy = end_y - start_y
				ax.add_patch(FancyArrow(start_x, start_y, dx, dy,
					width=0.05, head_width=0.35, head_length=0.18, length_includes_head=True, color='#444'))

	# Place one label per block at centroid
	for aa, rects in blocks:
		# Compute centroid over all rects composing the block (usually 1 rect, or 1 P1 box)
		total_area = 0.0
		cx_sum = 0.0
		cy_sum = 0.0
		for (x,y,w,h) in rects:
			area = w*h
			total_area += area
			cx_sum += (x + w/2) * area
			cy_sum += (y + h/2) * area
		cx = cx_sum / total_area
		cy = cy_sum / total_area
		# One letter per block
		ax.text(cx, cy, aa, ha='center', va='center', fontsize=font_size_label, fontweight='bold', color='#2b2b2b')

	if outfile:
		fig.savefig(outfile, bbox_inches='tight')
	return fig

# Wrapper: read TSV then draw

def draw_codon_regions_from_tsv(tsv_path: str, **kwargs) -> plt.Figure:
	aa_map = read_aa_table_tsv(tsv_path)
	return draw_codon_regions(aa_map, **kwargs)

if __name__ == '__main__':
	draw_codon_regions_from_tsv("aaTable.tsv", outfile="codon_regions.svg")
