# Builder stage
FROM python:3.11-slim as builder

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --user -r requirements.txt

COPY app .

# Runtime stage
FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY --from=builder /app /app

ENV PATH=/root/.local/bin:$PATH

EXPOSE 80

CMD ["python3", "main.py"]