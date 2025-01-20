repo_id = "QuantFactory/llama-3-sqlcoder-8b-GGUF"
# filename = "llama-3-sqlcoder-8b.Q4_1.gguf"
filename = "llama-3-sqlcoder-8b.Q2_K.gguf"

from transformers import AutoTokenizer, AutoModelForSeq2SeqLM, AutoModelForCausalLM

tokenizer = AutoTokenizer.from_pretrained(repo_id, gguf_file=filename)
model = AutoModelForCausalLM.from_pretrained(repo_id, gguf_file=filename)
# tokenizer.save_pretrained("./models")
# model.save_pretrained("./models")
print("still_alive")