*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://reqres.in/api/users/
${USER_ID}     2

*** Test Cases ***
Create a new user
    Given the API endpoint is ${BASE_URL}
    When I send a POST request to the endpoint with body tes-name SDET
    Then the response status code should be 201
    And the response body should contain the user's details
    And the response body should have the user's name as tes-name
    And the response body should have the user's job as SDET

*** Keywords ***
Given the API endpoint is ${url}
    Set Global Variable    ${BASE_URL}    ${url}

When I send a POST request to the endpoint with body ${name} ${job}
    Create Session    users  ${BASE_URL}
    &{data}=    Create dictionary  name=${name}  job=${job}
    ${response}=    POST On Session    users  /posts  json=${data}  expected_status=anything
    Set Global Variable    ${response}

Then the response status code should be 201
    Status Should Be    201

And the response body should contain the user's details
    Dictionary Should Contain Key    ${response.json()}     name
    Dictionary Should Contain Key    ${response.json()}     job
    Dictionary Should Contain Key    ${response.json()}     id
    Dictionary Should Contain Key    ${response.json()}     createdAt

And the response body should have the user's name as ${expected_name}
    Dictionary Should Contain Value    ${response.json()}  ${expected_name}

And the response body should have the user's job as ${expected_job}
    Dictionary Should Contain Value    ${response.json()}  ${expected_job}

