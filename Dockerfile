FROM python:3.12-slim
WORKDIR /app
COPY src ./src
COPY web ./web
RUN useradd --system --uid 10001 appuser && mkdir -p /var/lib/revenue && chown -R appuser:appuser /app /var/lib/revenue
USER appuser
EXPOSE 8000
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 APP_ENV=production HOST=0.0.0.0 PORT=8000 DATA_DIR=/var/lib/revenue ALLOW_DEVELOPMENT_HEADER_AUTH=false
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/api/health', timeout=2)"
CMD ["python", "src/server.py"]
