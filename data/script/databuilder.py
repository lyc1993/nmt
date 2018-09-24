from gtts import gTTS
from itertools import islice

line_number = 10000
wrong = []

def readZH(start):
    with open(r"E:\Independent Study\Project\rawData\en-zh\UNv1.0.en-zh.zh", "r",encoding='utf-8') as f1:
        lines = islice(f1,start,line_number)
        n = 0
        for sentence in lines:
            print('Processing zh:',n)
            try:
                tts = gTTS(text=sentence, lang='zh')
                tts.save(r"E:\Independent Study\Project\audioData\zh\zh%d.wav"%(n))
            except:
                print ('Error')
                wrong.append(n)
                n -= 1

            n += 1

    print (wrong)
    with open(r"E:\Independent Study\Project\wrong.txt", 'w') as wrongfile:
        for item in wrong:
            wrongfile.write("%s\n" % str(item))

def readEN(start):
    with open(r"E:\Independent Study\Project\rawData\en-zh\UNv1.0.en-zh.en", "r",encoding='utf-8') as f1:
        lines = islice(f1, start,line_number)
        n = 0
        for sentence in lines:
            if n not in wrong:
                print('Processing en:',n)
                tts = gTTS(text=sentence, lang='en')
                tts.save(r"E:\Independent Study\Project\audioData\en\en%d.wav"%(n))
                n += 1
            else:
                wrong.remove(n)


readZH(0)
readEN(0)