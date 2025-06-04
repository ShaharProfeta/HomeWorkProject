from fastapi import FastAPI
from fastapi.responses import PlainTextResponse

app = FastAPI()

@app.get("/hello", response_class=PlainTextResponse)
async def say_hello():
    return "Hello, world!"
