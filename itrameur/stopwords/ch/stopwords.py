# 读取停用词列表
with open('cn_stopwords.txt', 'r', encoding='utf-8') as file:
    stopwords = set([line.strip() for line in file if line.strip() != ''])

# 读取分词结果
with open('contextes-ch.txt', 'r', encoding='utf-8') as file:
    words = file.read().split()

# 移除停用词
filtered_words = [word for word in words if word not in stopwords]

with open('filtered_words.txt', 'w', encoding='utf-8') as file:
    for word in filtered_words:
        file.write(word + " ")  
