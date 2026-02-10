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

2. **Build and deploy the application:**
```bash
# Create a binary build from the current directory
oc start-build nodejs-api --from-dir=. --follow
```

3. **Get the route URL:**
```bash
oc get route nodejs-api
```

### Alternative: Direct Deployment

You can also deploy directly without the build:

```bash
# Apply all configurations
oc apply -f openshift-config.yaml

# Start the build from the current directory
cd nodejs-api
oc start-build nodejs-api --from-dir=. --follow
```

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