# 🚀 FastAPI Hello World

This is a simple FastAPI web application that exposes a single HTTP endpoint:  
`/hello` → returns `"Hello, world!"`

---

## 🧑‍💻 Run Locally

### 1. Install requirements

```bash
pip install fastapi uvicorn
```

### 2. Run the app

```bash
uvicorn back:app --reload
```

> Make sure your Python file is named `back.py`. If not, replace `back` with your filename.

### 3. Access it

[http://127.0.0.1:8000/hello](http://127.0.0.1:8000/hello)

---

## 🐳 Run with Docker

### 1. Build Docker image

```bash
docker build -t fastapi-hello .
```

### 2. Run the container

```bash
docker run -d -p 8000:8000 fastapi-hello
```

### 3. Access it

[http://localhost:8000/hello](http://localhost:8000/hello)

---

## 📂 Project Structure

```
.
├── back.py
├── Dockerfile
├── requirements.txt
└── README.md
```

---

## 📬 Example Output

Calling `/hello` returns:

```
Hello, world!
```

---
# ⚙️ Jenkins Pipeline


### ✅ Run Docker Compose

Now launch both containers:

```bash
docker-compose up --build
```


### What this does:

- `--build`: builds the FastAPI app from your Dockerfile
- Starts both `jenkins` and `fastapi-app` containers

#### Exposes:

- Jenkins at [http://localhost:8080](http://localhost:8080)
- FastAPI at [http://localhost:8000/hello](http://localhost:8000/hello)

---

### getting password for jenkins

```bash
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```