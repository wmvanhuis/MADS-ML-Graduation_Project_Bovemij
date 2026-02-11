FROM python:3.12-slim-bookworm

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

COPY pyproject.toml uv.lock ./

# Installeer alleen de productie-dependencies (GEEN dev-dependencies zoals Jupyter)
RUN uv sync --frozen --no-cache --no-dev

# Kopieer alleen de src map
COPY src/ ./src/

ENV PATH="/app/.venv/bin:$PATH"

# Start de app vanuit de src map
CMD ["python", "src/main.py"]