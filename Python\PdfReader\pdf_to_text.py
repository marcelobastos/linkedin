from pypdf import PdfReader
from tqdm  import tqdm
try:
    pdf = PdfReader("../sql-tuning-guide.pdf")
    qtd_pages = len(pdf.pages)
    text = ""
    bar  = tqdm(range(qtd_pages))
    bar.write("Stating convertion")
    for page in bar:
        text +=pdf.pages[page].extract_text()
    bar.write("Completed successful!")
except Exception as e:
    print(f"Error: {e}")