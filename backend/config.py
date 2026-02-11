"""Configuration for the LLM Council."""

import os
from dotenv import load_dotenv

load_dotenv()

# Unbound API key
UNBOUND_API_KEY = os.getenv("UNBOUND_API_KEY")

# Council members - list of Unbound model identifiers
COUNCIL_MODELS = [
    "gpt-5.1",
    "gemini-2.5-pro",
    "claude-opus-4-6",
    "grok-4",
]

# Chairman model - synthesizes final response
CHAIRMAN_MODEL = "gemini-2.5-pro"

# Unbound API endpoint
UNBOUND_API_URL = "https://api.getunbound.ai/v1/chat/completions"

# Data directory for conversation storage
DATA_DIR = "data/conversations"
