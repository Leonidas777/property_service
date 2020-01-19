# Property Service
The service that, given latitude and longitude of an object, its type and marketing type, returns a list of similar objects with their prices within a `5 kilometer` radius.

### The use scenario
- Alice, the real estate agent, is asked to estimate the sell price of an apartment that is located in Marienburger Straße 31 10405 Prenzlauer Berg, Berlin.
- Alice wants to figure out prices of similar apartments in Prenzlauer Berg
- Alice calls your service with the following params:
  - `lng` : `13.4236807`
  - `lat` : `52.5342963`
  - `property_type` : `apartment`
  - `marketing_type` : `sell`
- Alice receives a list of properties near the point she specified along with their prices.

### How to use
The service has the only one GET endpoint  `/stats`

So e.g. given the input of 

```
/stats?lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=sell
```

returns the list of properties required:

```
[
  {

    house_number: "31", 
    street: "Marienburger Straße", 
    city: "Berlin", 
    zip_code: "10405
    state: "Berlin",
    lat: '13.4211476',
    lng: '52.534993',
    price: '350000'

  },
  {

    house_number: "16", 
    street: "Winsstraße", 
    city: "Berlin", 
    zip_code: "10405"
    state: "Berlin",
    lat: '52.533533',
    lng: '13.425226',
    price: '320400'

  }
 # ... other properties 
]
```

If there is no property found:

```
{ "message": "No data for given location" }
```
with the status code `404`

If some of the input parameters are not valid(for example, `property_type=blabla`):

```
{ "message": "Params invalid", "params": ["property_type"] }
```
with the status code `422`

To iterate over all the properties found there should be provided the parameter `page`.
If it's not given, the first 1,000 properties will be loaded.
E.g. you have to pass the `page=2` parameter to get the second thousand properties(if found at all).