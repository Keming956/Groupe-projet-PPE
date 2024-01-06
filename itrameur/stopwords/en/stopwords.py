import re

def sans_url(word):
    patterns = [
        r'^https?://(?:www\.)?',
        r'^https?://en.wikipedia.org/wiki/',
        r'^www\.',
        r'http',
        r'https'
        r'^https?://',
        r'\.com',
        r'gov\.uk',
        r'wikipedia',
        r'wiki',
        r'\.org\.uk',
        r'\.gov'
    ]
    for pattern in patterns:
        word = re.sub(pattern, '', word)
    return word

def filter_words(text_file, stopwords_file, output_file):
    with open(stopwords_file, 'r', encoding='utf-8') as stop_file:
        stopwords = set([line.strip() for line in stop_file])

    with open(text_file, 'r', encoding='utf-8') as text:
        words = text.read().split()

    filtered_words = [sans_url(word) for word in words]

    filtered_words = [word for word in filtered_words if word.lower() not in stopwords]

    with open(output_file, 'w', encoding='utf-8') as output:
        for word in filtered_words:
            output.write(word + " ")

filter_words('../../contextes-en.txt', 'stopwords-en.txt', 'filtered_words.txt')
