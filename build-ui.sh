#!/bin/bash

# Build Firecrawl UI Docker image

set -e

echo "🔥 Building Firecrawl UI Docker image..."

# Navigate to UI directory
cd apps/ui/ingestion-ui

# Build the Docker image
docker build -t firecrawl-ui:latest .

echo "✅ Firecrawl UI Docker image built successfully!"
echo "📝 To run locally:"
echo "   docker run -p 8080:80 firecrawl-ui:latest"
echo "📝 To push to registry:"
echo "   docker tag firecrawl-ui:latest your-registry/firecrawl-ui:latest"
echo "   docker push your-registry/firecrawl-ui:latest"