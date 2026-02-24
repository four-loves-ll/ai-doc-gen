# Sofia Core: Symbiotic Documentation Configuration
project_name: "Hemet Flagship"
output_path: "./docs/sofia_core"
llm_model: "openai:gpt-4o"
log_level: "INFO"

# Protection Layer: Preventing recursive analysis and data noise
exclude_dirs: 
  - "venv"
  - ".git"
  - "tests"
  - "docs"
  - "__pycache__"

# Symbiotic Audit Settings (Optional Addition)
include_mission_statement: true
safety_protocol_check: true # Aligns with Aigis Cars Safety Protocols
project_name: "Hemet Flagship"
output_path: "./docs/sofia_core"
exclude_dirs: ["venv", ".git", "tests", "docs"]  # Added docs
llm_model: "openai:gpt-4o"
log_level: "INFO"
config.yamlFROM python:3.13

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH="/app/src"

# Install uv
RUN pip install --no-cache-dir uv

WORKDIR /app

# Copy dependency files first for better caching
COPY pyproject.toml uv.lock ./

# Install dependencies using uv sync
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

# Copy shared library and source code
COPY src ./src

WORKDIR /app

CMD ["uv", "run", "ai-doc-gen"]
