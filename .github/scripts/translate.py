from googletrans import Translator

def translate_readme(input_text, target_lang):
    translator = Translator()
    translated = translator.translate(input_text, dest=target_lang)
    translated_text = translated.text
    
    # add hint for automatically translation
    translated_text = f"Note: This is an automatically translated file. Original content from [here](https://github.com/dbt1/debian-tuxbox-base/blob/master/README-de.md):\n\n{translated_text}"

    return translated_text

if __name__ == "__main__":
    input_text = open("README-de.md", "r").read()
    target_lang = "en"  # target language is english
    translated_text = translate_readme(input_text, target_lang)

    with open("README-en.md", "w") as outfile:
        outfile.write(translated_text)
