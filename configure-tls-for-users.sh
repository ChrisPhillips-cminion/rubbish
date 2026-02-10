#!/bin/bash

# Configuration
SERVER="manager.apps.698905d36b5150aa779bbc62.ap1.techzone.ibm.com"
PASSWORD="krtj2026"
REALM="provider/default-idp-2"
TLS_PROFILE_URL="https://api.apps.698905d36b5150aa779bbc62.ap1.techzone.ibm.com/api/orgs/00ebd798-e6fa-48e8-b04b-6a801908a5ae/tls-client-profiles/5d810cdd-869e-489d-93a2-253916f40fbf"

# Loop through users 02 to 49
for i in $(seq -f "%02g" 50 50); do
    USERNAME="student${i}"
    echo "Processing ${USERNAME}..."
    
    # Login as the user
    apic12 login --server ${SERVER} --username ${USERNAME} --password ${PASSWORD} --realm ${REALM}  --insecure-skip-tls-verify 2>&1 | grep -q "successfully" 
    
    apic12 apis:get  --server ${SERVER} --org ${USERNAME} --catalog sandbox --scope catalog   --insecure-skip-tls-verify --scope catalog student50api:1.0  
    # apic12 configured-portal-services:create wm-devportal-service.yaml  --server ${SERVER} --org ${USERNAME} --catalog sandbox --scope catalog   --insecure-skip-tls-verify
        
    echo ""
done

echo "Configuration complete!"

# Made with Bob
