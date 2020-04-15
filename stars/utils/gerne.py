import os
def saveModel(arr):
    if os.path.exists("./oo.csv"):
        pass
class LastTextFileLine:
    REL_ILE_END = 2
    def lastTextFileLine(self,file, len_guess=1):
        text = file.read(1)
        if not text:
            return b''
        file.seek(-1, self.REL_FILE_END)
	text = file.read(1)
        tot_sz = 1
        if text != b'\n':
            file.seek(0, self.REL_FILE_END)
            tot_sz = 0
        blocks = []
        j = file.tell()
        not_done = True
        block_sz = len_guess
        while not_done:
            if j < block_sz:
                block_sz = j
                not_done = False
            tot_sz += block_sz
            file.seek(-tot_sz, self.REL_FILE_END)         
            text = file.read(block_sz)
            i = text.rfind(b'\n')
            if i != -1:
                text = text[i+1:]+b''.join(reversed(blocks))
                return str(text)
            else:
                blocks.append(text)
                block_sz <<= 1
                if block_sz >=j:
                    block_sz=1
                j = j - block_sz
        return str(b''.join(reversed(blocks)))
