# GoHighLevel

A Node.js integration using the official GoHighLevel API client.

## Installation

```bash
npm install
```

## Setup

1. Clone the repo:
   ```bash
   git clone https://github.com/KaiHatchman/GoHighLevel.git
   cd GoHighLevel
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Add your GoHighLevel API key in `index.js`:
   ```js
   const client = new ApiClient({ apiKey: 'YOUR_API_KEY' });
   ```

## Usage

```bash
node index.js
```

## Dependencies

- [@gohighlevel/api-client](https://www.npmjs.com/package/@gohighlevel/api-client) - Official GoHighLevel API client
