# Kustomize

## see generated output
kubectl kustomize k8s/overlays/test

## apply it
kubectl apply -k k8s/overlays/test

## Test
The deployment has been tested in a default GKE cluster

### self-signed SSL
## SSL cert
generated with the following command

```
openssl req \
-x509 \
-nodes \
-days 365 \
-newkey rsa:2048 \
-keyout spacetrouble.key \
-out spacetrouble.crt \
-subj "/CN=booking.spacetrouble.com/O=spacetrouble"
```

### ADD

based on example
```
curl -k --location --request POST 'https://35.232.61.196:443/v1/bookings' \
--header 'Content-Type: application/json' \
--header 'Host: booking.spacetrouble.com' \
--data-raw '{
    "FirstName": "Giorgos",
    "LastName": "Komninos",
    "Gender": "male",
    "LaunchpadID": "5e9e4501f509094ba4566f84",
    "DestinationID": "05c7f2ca-aa9a-4ea8-a6d5-4cb691468830",
    "Date": "2041-10-25",
    "Birthday": "1928-12-01"
}'
```

### List
`curl -k --location --header 'Host: booking.spacetrouble.com' --request GET 'https://35.232.61.196:443/v1/bookings' --header 'Content-Type: application/json'`

```
{"bookings":[{"ID":"93955e95-0d76-4f66-a6ae-9c80fcd04f13","User":{"Birthday":"1928-12-01","Gender":"male","ID":"a2cd4a37-c13b-4297-a184-6e85d282300e","FirstName":"Giorgos","LastName":"Komninos"},"Flight":{"Date":"2041-10-25","ID":"4099b317-d2bc-4d52-b1c7-896d4846e73b","LaunchpadID":"5e9e4501f509094ba4566f84","Destination":{"ID":"05c7f2ca-aa9a-4ea8-a6d5-4cb691468830","Name":"Mars"}},"Status":"active","CreatedAt":"2022-10-14T16:17:23.44407Z"}],"limit":10,"cursor":"MjAyMi0xMC0xNFQxNjoxNzoyMy40NDQwN1osOTM5NTVlOTUtMGQ3Ni00ZjY2LWE2YWUtOWM4MGZjZDA0ZjEz"
```
