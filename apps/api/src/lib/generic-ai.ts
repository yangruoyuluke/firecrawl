import { createOpenAI } from "@ai-sdk/openai";
import { anthropic } from "@ai-sdk/anthropic";
import { groq } from "@ai-sdk/groq";
import { google } from "@ai-sdk/google";
import { createOpenRouter } from "@openrouter/ai-sdk-provider";

// Optional imports with fallbacks
let createOllama: any;
let fireworks: any;
let deepinfra: any;
let createVertex: any;

try {
  createOllama = require("ollama-ai-provider").createOllama;
} catch (e) {
  createOllama = null;
}

try {
  fireworks = require("@ai-sdk/fireworks").fireworks;
} catch (e) {
  fireworks = null;
}

try {
  deepinfra = require("@ai-sdk/deepinfra").deepinfra;
} catch (e) {
  deepinfra = null;
}

try {
  createVertex = require("@ai-sdk/google-vertex").createVertex;
} catch (e) {
  createVertex = null;
}

type Provider =
  | "openai"
  | "ollama"
  | "anthropic"
  | "groq"
  | "google"
  | "openrouter"
  | "fireworks"
  | "deepinfra"
  | "vertex";

// Determine default provider based on available environment variables
const defaultProvider: Provider = 
  process.env.OPENROUTER_API_KEY
    ? "openrouter"
    : process.env.OLLAMA_BASE_URL && createOllama
    ? "ollama"
    : "openai";

const providerList: Record<Provider, any> = {
  openai: createOpenAI({
    apiKey: process.env.OPENAI_API_KEY || process.env.OPENROUTER_API_KEY,
    baseURL: process.env.OPENAI_BASE_URL || "https://openrouter.ai/api/v1",
  }),
  ollama: createOllama ? createOllama({
    baseURL: process.env.OLLAMA_BASE_URL || "http://localhost:11434",
  }) : null,
  anthropic,
  groq,
  google,
  openrouter: createOpenRouter({
    apiKey: process.env.OPENROUTER_API_KEY || process.env.OPENAI_API_KEY,
  }),
  fireworks: fireworks || null,
  deepinfra: deepinfra || null,
  vertex: createVertex ? createVertex({
    project: "firecrawl",
    baseURL: "https://aiplatform.googleapis.com/v1/projects/firecrawl/locations/global/publishers/google",
    location: "global",
    googleAuthOptions: process.env.VERTEX_CREDENTIALS ? {
      credentials: JSON.parse(atob(process.env.VERTEX_CREDENTIALS)),
    } : {
      keyFile: "./gke-key.json",
    },
  }) : null,
};

export function getModel(name: string, provider: Provider = defaultProvider) {
  if (name === "gemini-2.5-pro") {
    name = "gemini-2.5-pro";
  }
  
  const selectedProvider = providerList[provider];
  if (!selectedProvider) {
    throw new Error(`Provider ${provider} is not available or not configured`);
  }
  
  return process.env.MODEL_NAME
    ? selectedProvider(process.env.MODEL_NAME)
    : selectedProvider(name);
}

export function getEmbeddingModel(
  name: string,
  provider: Provider = defaultProvider,
) {
  const selectedProvider = providerList[provider];
  if (!selectedProvider || !selectedProvider.embedding) {
    throw new Error(`Embedding model for provider ${provider} is not available`);
  }
  
  return process.env.MODEL_EMBEDDING_NAME
    ? selectedProvider.embedding(process.env.MODEL_EMBEDDING_NAME)
    : selectedProvider.embedding(name);
}
