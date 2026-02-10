# Simple Node.js API

A simple Node.js Express API that returns the origin IP address.

## API Endpoints

- `GET /` - API information and available endpoints
- `GET /ip` - Returns origin IP address in JSON format: `{"origin": "x.x.x.x"}`
- `GET /health` - Health check endpoint

## Local Development

```bash
# Install dependencies
npm install

# Run in development mode
npm run dev

# Run in production mode
npm start
```

The API will be available at `http://localhost:8080`

## OpenShift Deployment

### Prerequisites
- OpenShift CLI (`oc`) installed
- Logged into OpenShift cluster

### Deployment Steps

1. **Create the OpenShift resources:**
```bash
oc apply -f openshift-config.yaml
```

2. **The build will start automatically from GitHub:**
The BuildConfig is configured to pull from:
- Repository: https://github.com/ChrisPhillips-cminion/rubbish
- Branch: main
- Context Directory: nodejs-api

3. **Monitor the build:**
```bash
oc logs -f bc/nodejs-api
```

4. **Get the route URL:**
```bash
oc get route nodejs-api
```

### Manual Build Trigger

To manually trigger a build:

```bash
oc start-build nodejs-api
```

### GitHub Webhook

The BuildConfig includes a GitHub webhook trigger. To set it up:

1. Get the webhook URL:
```bash
oc describe bc/nodejs-api | grep -A 1 "Webhook GitHub"
```

2. Add the webhook URL to your GitHub repository settings under "Webhooks"

## Testing the API

Once deployed, test the API:

```bash
# Get the route
ROUTE=$(oc get route nodejs-api -o jsonpath='{.spec.host}')

# Test the root endpoint
curl https://$ROUTE/

# Test the IP endpoint
curl https://$ROUTE/ip
```

Expected response from `/ip`:
```json
{
  "origin": "129.41.56.3"
}
```

## Configuration

The application uses the following environment variables:
- `PORT` - Server port (default: 8080)

## Resources

The deployment includes:
- **ImageStream**: For storing built container images
- **BuildConfig**: For building the application from source
- **DeploymentConfig**: For managing application deployment
- **Service**: For internal cluster communication
- **Route**: For external HTTPS access with automatic redirect