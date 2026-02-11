#!/bin/bash

# LLM Council - Start script

CERT_DIR="/tmp/llm-council-certs"
CORP_CERT="$CERT_DIR/thehutgroup.pem"
COMBINED_CERT="$CERT_DIR/ca-bundle-combined.pem"

mkdir -p "$CERT_DIR"
curl -sfo "$CORP_CERT" https://thg-certificate.thgaccess.com/thehutgroup.pem
cat /etc/ssl/certs/ca-certificates.crt "$CORP_CERT" > "$COMBINED_CERT"

export SSL_CERT_FILE="$COMBINED_CERT"
export NODE_EXTRA_CA_CERTS="$CORP_CERT"
export UV_NATIVE_TLS=true

echo "Starting LLM Council..."
echo ""

# Start backend
echo "Starting backend on http://localhost:8001..."
uv run python -m backend.main &
BACKEND_PID=$!

# Wait a bit for backend to start
sleep 2

# Start frontend
echo "Starting frontend on http://localhost:5173..."
cd frontend
npm run dev &
FRONTEND_PID=$!

echo ""
echo "✓ LLM Council is running!"
echo "  Backend:  http://localhost:8001"
echo "  Frontend: http://localhost:5173"
echo ""
echo "Press Ctrl+C to stop both servers"

# Wait for Ctrl+C
trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit" SIGINT SIGTERM
wait
