

from pypinyin import pinyin, Style
import csv

# Custom tone mapping
tone_map = {
    1: '7',
    2: '0',
    3: '5',
    4: '4',
    5: '8'  # neutral tone
}

# Read names from file
with open('names.txt', 'r', encoding='utf-8') as file:
    names = [line.strip() for line in file if line.strip()]

# Prepare output data
output_rows = []

for name in names:
    # Get pinyin with tone numbers and diacritics
    pinyin_tone3 = pinyin(name, style=Style.TONE3, heteronym=False)
    pinyin_diacritics = pinyin(name, style=Style.TONE, heteronym=False)

    # Flatten and process
    syllables_tone3 = [s[0] for s in pinyin_tone3]
    syllables_diacritics = [s[0] for s in pinyin_diacritics]

    # Extract tone pattern
    tone_pattern = '_'
    for syllable in syllables_tone3:
        for char in syllable:
            if char.isdigit():
                tone_pattern += tone_map[int(char)]
                break
        else:
            tone_pattern += '0'

    tone_pattern += '_'

    # Romanized names
    romanized_no_tone = ' '.join(s[:-1] if s[-1].isdigit() else s for s in syllables_tone3)
    romanized_with_tone = ' '.join(syllables_diacritics)

    # Append to output
    output_rows.append([name, romanized_no_tone, romanized_with_tone, tone_pattern])

for row in output_rows:
    # Ensure all elements are strings
    print('\t'.join(str(cell) for cell in row))

