*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://reqres.in/api/users/
${USER_ID}     2

*** Test Cases ***
Retrieve a Single User by ID
    Given the API endpoint is ${BASE_URL}
    When I send a GET request to the endpoint with id ${USER_ID}
    Then the response status code should be 200
    And the response body should contain the user's details
    And the response body should have the user's email as janet.weaver@reqres.in
    And the response body should have the user's name as Janet

*** Keywords ***
Given the API endpoint is ${url}
    Set Global Variable    ${BASE_URL}    ${url}

When I send a GET request to the endpoint with id ${id}
    ${response}=    GET    ${BASE_URL}${id}
    Set Global Variable    ${response}

Then the response status code should be 200
    Status Should Be    200

And the response body should contain the user's details
    Dictionary Should Contain Key    ${response.json()}  data
    Dictionary Should Contain Key    ${response.json()}[data]  email
    Dictionary Should Contain Key    ${response.json()}[data]  first_name
    Dictionary Should Contain Key    ${response.json()}[data]  last_name
    Dictionary Should Contain Key    ${response.json()}[data]  avatar

And the response body should have the user's email as ${expected_email}
    Dictionary Should Contain Value    ${response.json()}[data]  ${expected_email}

And the response body should have the user's name as ${expected_name}
    Dictionary Should Contain Value    ${response.json()}[data]  ${expected_name}
