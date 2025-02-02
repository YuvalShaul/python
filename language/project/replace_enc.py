import random

def set_config(include_key = False):
    conf = {}
    conf['include_key'] = include_key
    return conf
    

def create_enc_key():
    # Key: = {'
    #           type': "enc",
    #          'values': {'a':'n', 'b':'d', ....}
    #        }
    # returns key
    letters = [ chr(num) for num in range(ord('a'), ord('z') + 1) ]
    letters.extend([' ', '!', ','])
    shuffled = letters.copy()
    random.shuffle(shuffled)
    letters_dict = {letters[i]:shuffled[i] for i in range(len(letters)) }
    key = {'type': 'enc', 'values':    letters_dict}
    return key

def create_dec_key(enc_key):
    # return decrypt key
    enc_values = enc_key['values']
    dec_values = {}
    for k,v in enc_values.items():
       dec_values[v] = k
    dec_key = {'type':'dec', 'values':dec_values}
    return dec_key
    

def encrypt_text(text, enc_key, strict=False, conf=None):
    enc_text = []
    enc_values = enc_key['values']
    for letter in text:
        enc_text.append(enc_values[letter])
    return("".join(enc_text))

def decrypt_text(enc_text, dec_key=None, enc_key=None, conf=None):
    dec_text = []
    if (dec_key is None):
        if enc_key is not None:
            dec_key = create_dec_key(enc_key)
    dec_values = dec_key['values']
    for letter in enc_text:
        dec_text.append(dec_values[letter])
    return("".join(dec_text))

# call:
# decrypt_text(my_text, enc_key = my_enc_key)

