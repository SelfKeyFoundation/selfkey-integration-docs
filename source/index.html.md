---
title: SelfKey API Documents

language_tabs: # must be one of https://git.io/vQNgJ
  - javascript
  - shell

toc_footers:
  - <a href='mailto:help@selfkey.org'>help@selfkey.org</a>

includes:
  - errors

search: true
---

# Introduction

**Welcome to the SelfKey API**

The SelfKey ecosystem is broken down into three main parts. First is the [SelfKey Identity Wallet](https://www.selfkey.org/download), a desktop Ethereum wallet on Mac OS, Windows, and Linux. Second is the [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd), a Chrome browser plugin that allows a user to authenticate with websites using their Decentralized Identifier (DID). Third is the SelfKey Marketplace, where users can register for financial products and services with one click.

There are six sections to this document:

1. **SelfKey Extension**: Our Chrome browser plugin and how it works.
2. **SelfKey Marketplace**: Sign up new users and onboard them with our marketplace.
3. **Configuring Your Website**: Both frontend, backend, and our API endpoints.
4. **SelfKey Client Lib**: Frontend website library to authenticate with the [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd).
5. **Authentication**: How to prove users have ownership over a Decentralized Identifier (DID).
6. **REST API Spec**: Detailed spec of the SelfKey APIs.

<aside class="notice">
Our compliance solution <a href ="https://www.kyc-chain.com">KYC-Chain</a> has every integration above built in by default.
</aside>

**How To Use This Document**

You can use our API to access endpoints in the SelfKey Identity Wallet desktop application and the [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd) browser plugin. If anything is unclear, please contact us at [help@selfkey.org](mailto:help@selfkey.org) and we can help you with the integrations. The format of this document is broken down into three panels:

* **Left Panel**: Table of Contents & Search Bar
* **Middle Panel**: Information & Documentation
* **Right Panel**: Code Samples by Language


# A. SelfKey Extension

## Overview

When a user has installed the [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd) browser plugin, they can deploy their Decentralized Identifier (DID) for authentication and logging into your website.

By installing the [Selfkey-Client-Lib](#e-selfkey-client-lib), a "Login With SelfKey" button will be displayed on your website. The [SelfKey Identity Wallet](https://www.selfkey.org/download) (Mac OS/Win/Linux) acts as the backend layer that connects to the Ethereum blockchain and a user's Decentralized Identifier (DID).

## Part 1: User Requirements
For a user to successfully use their Decentralized Identifier (DID) as an authentication method, there are two applications that must be installed and activated by the user.

* Step 1: [SelfKey Identity Wallet] (https://selfkey.org/download/) must be installed, opened, and logged in.
* Step 2: [Selfkey Extension] browser plugin must be installed and activated.

<aside class="success">
Note: If both are not installed, there will be instructions after clicking "Login with SelfKey" on your website.
</aside>


## Part 2: Frontend Integration

To enable the [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd) as an authentication method for your website, a JavaScript library needs to be installed. This displays a *"Login With SelfKey"* button on your website for users to click. Clicking this button starts the login workflow.

Exact instructions can be found in [Selfkey Client Lib](#e-selfkey-client-lib) and [configuring your website](#c-configuring-your-website).


### Installation Instructions:

1. Integrate [*Selfkey Client Lib*](#e-selfkey-client-lib) into your website.
2. Select where you want the *"Login With SelfKey"* button to appear.
3. Initialize the *"Login With SelfKey"* button by passing [SelfKey Extension Config](#d-configuring-your-website) to [Selfkey Client Library](#e-selfkey-client-lib).


## Part 3: Backend Integration

<aside class="notice">
Question: Are you using <a href ="https://www.kyc-chain.com">KYC-Chain</a> or an in-house compliance tool for verifying identities of new users?
</aside>

We have two options for the [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd) backend integration.

### Option 1: For Non KYC-Chain Clients

The following endpoint should be implemented on your backend: [Authentication](#e-authentication)

* **Authentication** – Challenge
* **Authentication** – Challenge Reply
* **LWS** - Create User file
* **LWS** - Get user token
* **LWS** - Login endpoint (optional if onAuthCallback is implemented)

Currently we don't to have tools to make this process easier, but there are several options coming soon:

* **[Selfkey Node.js lib]** - WORK IN PROGRESS
* **[Selfkey ASP.NET lib]** - WORK IN PROGRESS
* **[Selfkey Service]** - WORK IN PROGRESS

### Option 2: For KYC-Chain Clients

If your website is integrated with KYC-Chain, you can leverage our existing [Authentication](#e-authentication) endpoints:

1. KYC Chain should configure your instance to use RSA algorithm for token signatures.
2. You should receive a RSA public key and configure it for token verification.
3. You should override authentication endpoints in their config to point to KYC-Chain.


# B. SelfKey Marketplace

## 1: Crypto Exchanges

<aside class="notice">
Currently, integration for the SelfKey Marketplace is only available for crypto exchange clients that use KYC-Chain, our in-house compliance tool that helps with KYC onboarding of new users.
</aside>


####

```shell
{
        "rootEndpoint": INSTANCE_URL,
        "endpoints": {
            "/templates/:id": "INSTANCE_URL/templates/:id?format=minimum"
            "/user/token": "INSTANCE_URL/auth/token"
        }
    }
```

```javascript

{
        "rootEndpoint": INSTANCE_URL,
        "endpoints": {
            "/templates/:id": "INSTANCE_URL/templates/:id?format=minimum"
            "/user/token": "INSTANCE_URL/auth/token"
        }
    }
```

### How To Integrate A New Exchange (KYC-Chain Clients)

Integration with crypto exchanges that use [KYC-Chain](https://www.kyc-chain.com) for compliance is far more seamless because there is a default integration built in with SelfKey. The configuration for them will usually look like this to the right:


### How To Integrate A New Exchange (Non-KYC-Chain Clients)

Not currently available. Will update API Documentation when tools are ready for non-clients.


## 2: Incorporations

<aside class="warning">More documentation coming soon.</aside>



## 3: Bank Accounts

<aside class="warning">More documentation coming soon.</aside>


# C. Configuring Your Website

## Overview

Using the [SelfKey Identity Wallet](https://www.selfkey.org/download) (desktop application) and [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd) (browser plugin), we can utilize a user's Decentralized Identifier (DID) for authentication to your website. The configuration object has similar structure for both SelfKey Extension and SelfKey Marketplace integrations, but has several distinctions for each and is usually placed in different places.

The SelfKey Extension configuration object would be usually passed directly when initialized inside [Selfkey-Client-Lib](#e-selfkey-client-lib). The SelfKey Marketplace integration object will usually be stored in the Selfkey API (Airtable inside *relying_party_config field*), you will need to submit the configuration (or all relevant details) to us.

## 1: Common Configuration Properties

There are two main properties that exist between both objects regarding integration endpoints.

### rootEndpoint

* This is the default integration endpoint.
* If no overrides, by default the [SelfKey Identity Wallet](https://www.selfkey.org/download) will try to guess all endpoints by appending their name to it.  
* If the *rootEndpoint* provided is not an absolute URL, it will be prepended with website URL (see website config option).

*Example:*

* **rootEndpoint**: "https://yoursite.com/api/v1/selfkey/"
* The [SelfKey Identity Wallet](https://www.selfkey.org/download) will derive auth/challenge endpoint and templates endpoint by simply appending their name to root endpoint:
* **Challenge**: https://yoursite.com/api/v1/selfkey/auth/challange
* **Templates**: https://yoursite.com/api/v1/selfkey/template

### endpoints


* The endpoints option contain overrides to the default API endpoint mechanisms.
* Override config supports both absolute URLs and relative URLs.
* Our API is configurable in terms of URLs to the point that different endpoints can run on different services as long as they can use a common [Authentication & Proof Of Ownership Challenge-Response] scheme.

*Example:*

**rootEndpoint of "https://yoursite.com/api/v1/selfkey/"**

* Default behavior for the template endpoint is to use: https://yoursite.com/api/v1/selfkey/templates endpoint, but there are two options for relative override and absolute override:

* **Relative override**: Instead of default, it will use -> *https://yoursite.com/api/v1/selfkey/repository/templates*

`{ "endpoints" : "/templates": "/repository/templates" }`

* **Absolute override**: Instead of default, it will use -> *https://api.yoursite.com/repository/templates*

`{ "endpoints" : "/templates": "https://api.yoursite.com/repository/templates" }`


### Complete List Of Possible endpoints

* '/auth/challenge' (COMMON)
* '/auth/token' (COMMON)
* '/users' (LWS and possibly marketplace – TBD by product)
* '/templates' (Marketplace)
* '/templates/:id' (Marketplace)
* '/applications' (Marketplace)
* '/applications/:id' (Marketplace)
* '/applications/:id/payments' (Marketplace)
* '/applications' (Marketplace)
* '/applications/:id' (Marketplace)
* '/files' (Marketplace, and a similar endpoint will be speced out for LWS)
* '/login'

### Parameterized Endpoints:
* Some endpoints like *'/templates/:id'* will contain resource ID as part of the URL
* The SelfKey Identity Wallet will replace *":id "* for actual resource ID on communication.


### Meta
* This config option is not used by the SelfKey Identity Wallet.
* It is an object that will be passed to relying party on certain endpoint requests as is.
* Currently it is used by the [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd) for a user creation endpoint – TBD if it should be passed on other ones
* Example: `{meta: { applicationId: '333444' }}`


## 2: SelfKey Extension Configuration



The configuration object is passed differently between different client lib implementations (for different frameworks).
Please consult with Selfkey Client Lib for specifics.

**ui**

This option is used to define how Selfkey Client Lib interacts with your website. Currently only one option is available inside it: **el**. We hope to extend our library and provide more UI customization options like theme and CSS overrides in the future..

**el**

* Can be one of the following: DOM element, css query selector, or an array containing a mixture of the previous two.
* The current behavior of the [Selfkey-Client-Lib](#e-selfkey-client-lib) is to use them as containers for the [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd) login button
* Example: `{ui: {el: '.lwsClient'}}`



####

```shell
{
   website: {
       name: 'LWS Example Site',
       url: 'https://yoursite.com/',
       termsUrl: 'https://yoursite/terms.html',
       policyUrl: 'https://yoursite.com/policy.html',
   },
}
```
```javascript

{
   website: {
       name: 'LWS Example Site',
       url: 'https://yoursite.com/',
       termsUrl: 'https://yoursite/terms.html',
       policyUrl: 'https://yoursite.com/policy.html',
   },
}
```
**website**

* Information about the website integrating LWS.
* This information is displayed for the user on the extension popup.
* **name**: Name of the website
* **url**: Canonical url for the website
* **termsUrl**: a link to service terms of service
* **policyUrl**: a link to service privacy policy



### attributes

```Shell
attributes: [
           {
               id: "first_name",
               label: "First Name",
               schemaId: "http://platform.selfkey.org/schema/attribute/first-name.json"
           },
           {
               label: "Last Name",
               attribute: "http://platform.selfkey.org/schema/attribute/last-name.json"
           },
           {
               id: "email",
               schemaId: "http://platform.selfkey.org/schema/attribute/email.json"
           },
           "http://platform.selfkey.org/schema/attribute/email.json"
],
```




* A list of attributes that are required for signup with the service.
* Each attribute can contains the following information:

* **schemaId**: A url to id attribute in https://platform.selfkey.org/repository.json and possibly other repositories in future. (required)
* **id**: an unique identifier for a field on relying party server (optional)
* **label**: a label for this attribute to be displayed for the user (optional, if not provided, we will use the title attribute of schema)
* Alternatively an attribute can be a simple string which representing schemaId
* NOTE: Current implementation is not updated with this config options, tracked in issue https://github.com/SelfKeyFoundation/Identity-Wallet/issues/1001


####

```javascript
onAuthResponse: function(err, res, ui) {
                console.log('OnAuthResponse', err, res, ui);
                if (err) {
                    document.getElementById(
                        'user-token'
                    ).innerHTML = `UserPayload Error: ${JSON.stringify(err)}`;
                } else {
                    document.getElementById(
                        'user-token'
                    ).innerHTML = `UserPayload: ${JSON.stringify(res)}`;
                }


                if (!ui) return;
                setTimeout(() => {
                    ui.popup.content.innerHTML = '<b>Closing popup</b>';
                }, 1000);
                setTimeout(() => {
                    ui.popup.hide();
                }, 3000);
            }
```

### onAuthCallback



* An optional callback that can be passed to configuration object.
* If it is passed, client-lib will call it instead of performing the default login behavior (calling login endpoint and redirecting to provided URL).
* It will be called on each login/signup attempt.

**Arguments**:

* error: Will contain error object if auth/signup failed. Will be null on successful authentication.
* response: Will contain response object. Not modified, as returned from /auth/token endpoint.
* ui: Will contain a reference to selfkey ui elements. Will allow to insert custom html and hide popup if necessary.
* NOTE: needs to be examined from security perspective, but probably safe to use.



### extensionId

* It is an internal parameter, should not be documented for the public.
* It is used to specify [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd) id that is loaded in the browser and is used by Selfkey-lib to communicate with the extension, used for development purposes.





### Complete SelfKey Extension Configuration Example
> Complete SelfKey Extension Configuration Example

```javascript
{
            ui: {
                el: '.lwsClient'
            },
            website: {
                name: 'LWS Example',
                url: 'http://localhost:3030/',
                termsUrl: 'http://localhost:3030/terms.html',
                policyUrl: 'http://localhost:3030/policy.html'
            },
            rootEndpoint: '/api/v1/selfkey',
            attributes: [
                {
                    id: 'first_name',
                    label: 'First Name',
                    schemaId: 'http://platform.selfkey.org/schema/attribute/first-name.json'
                },
                {
                    id: 'last_name',
                    label: 'Last Name',
                    schemaId: 'http://platform.selfkey.org/schema/attribute/last-name.json'
                },
                {
                    id: 'email',
                    label: 'Email',
                    schemaId: 'http://platform.selfkey.org/schema/attribute/email.json'
                }
            ],
            onAuthResponse: function(err, res, ui) {
                console.log('OnAuthResponse', err, res, ui);
                if (err) {
                    document.getElementById(
                        'user-token'
                    ).innerHTML = `UserPayload Error: ${JSON.stringify(err)}`;
                } else {
                    document.getElementById(
                        'user-token'
                    ).innerHTML = `UserPayload: ${JSON.stringify(res)}`;
                }


                if (!ui) return;
                setTimeout(() => {
                    ui.popup.content.innerHTML = '<b>Closing popup</b>';
                }, 1000);
                setTimeout(() => {
                    ui.popup.hide();
                }, 3000);
            }
 }
```

<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<center>*This area intentionally left blank (see right).*</center>

## 3: SelfKey Marketplace Configuration

There are no special configuration options are available for the SelfKey Marketplace at this point.


### Complete SelfKey Marketplace Configuration Example:

```javascript
{
        rootEndpoint: "https://kyc-instance-url.com/api/v1/",
        endpoints: {
            '/templates/:id': `https://kyc-instance-url.com/api/v1/templates/:id?format=minimum`
        }
}
```


* This is a simple integration that will only contain the root endpoint.
* If you are using our compliance solution KYC-Chain, integrations will also contain an override for the template endpoints.



# E. SelfKey Client Lib

* SelfKey Client Lib is a client library used to integrate our Chrome browser plugin [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd) to your website.
* We have four sample client integrations with Javascript, Angular 1, React, and Vue.
* Repository: https://github.com/SelfKeyFoundation/selfkey-js-client
* NOTE: All npm repos should be grouped under `@seflkey` organization prefix

## 1. Javacript Client

* URL: https://www.npmjs.com/package/lws-js-client


**Sample Integration**:

* https://github.com/SelfKeyFoundation/selfkey-js-client/tree/master/packages/js/example
* NOTE: This is a sample integration, the API may be further updated since then.

**Usage**:

* NPM with webpack or similar tools

**Install With NPM**

`npm install lws-js-client --save`

**Usage in Code**

`import lws from 'lws-js-client'
lws.init(config);`


**CDN**

* We use https://unpkg.com/ as our CDN provider
* Include the following script in your webpage:

**Include Tag In Page**

`<script src="https://unpkg.com/lws-js-client@1.0.0-beta.26/dist/lws.min.js"></script>`


Unpkg works directly with npm, and you can include any file in the repository, the structure of the link is:

`https://unpkg.com/<REPOSITORY_NAME>@<PACKAGE_VERSION>/<FILE_PATH>`

**Usage In Code**

`lws.init(config);`


**API Reference**:

Init

* The init method should be called when you want to display the LWS button (the most common use case is to do it on page load).
* The init method can be applied for to setup multiple buttons on the page, an array of container elements or a query selector should be provided for that.
* The init method can be called only once. If you need to change your setup, you need to call lws.teardown() first, then you can call it again.

`lws.init(config)`

Arguments:

* config – LWS process configuration as explained in Relying Party Configuration.

Prerequisites:

* DOM should be loaded
* Integrator should know query selector, or provide a DOM element to serve as container for LWS button


Init Example:

####

```shell

lws.init({
            ui: {
                el: '.lwsClient'
            },
            website: {
                name: 'LWS Example',
                url: 'http://localhost:3030/',
                termsUrl: 'http://localhost:3030/terms.html',
                policyUrl: 'http://localhost:3030/policy.html'
            },
            rootEndpoint: '/api/v1/selfkey',
            attributes: [
                {
                    id: 'first_name',
                    label: 'First Name',
                    schemaId: 'http://platform.selfkey.org/schema/attribute/first-name.json'
                },
                {
                    id: 'last_name',
                    label: 'Last Name',
                    schemaId: 'http://platform.selfkey.org/schema/attribute/last-name.json'
                },
                {
                    id: 'national_id',
                    label: 'National ID',
                    schemaId: 'http://platform.selfkey.org/schema/attribute/national-id.json'
                }
           ]
});
```


**teardown**

An opposite method to *init*, will destroy all that *init* have setup.

* This method is useful when you want to change the config provided to init. You would call teardown and then init with new config
* In web app when navigation happens in javascript, this method should be called for clean up

**Usage in Code**

`lws.teardown();`

## 2. Angular 1 Client

* URL: https://www.npmjs.com/package/lws-angularjs-client

Sample Integration:

* https://github.com/SelfKeyFoundation/selfkey-js-client/tree/master/packages/angularjs/example
* NOTE: This is a sample integration, the API may be further updated since then.

**Usage**

NPM with webpack or similar tools

**Install With NPM**

`npm install lws-angularjs-client --save`

**Usage in Code**

####

```Shell
require('lws-angularjs-client');

angular.module('lwsExample', ['lwsSdk'])
            .controller('login', ['$scope', ($scope) => {
                $scope.website = {
                    name: 'LWS Example',
                    url: 'http://localhost:3031/',
                    termsUrl: 'http://localhost:3031/terms.html',
                    policyUrl: 'http://localhost:3031/policy.html',
                };
                $scope.rootEndpoint = 'http://localhost:3030/api/v1/selfkey',
                $scope.attributes = [
                    {
                        id: "first_name",
                        label: "First Name",
                        schemaId: "http://platform.selfkey.org/schema/attribute/first-name.json"
                    },
                    {
                        id: "last_name",
                        label: "Last Name",
                        schemaId: "http://platform.selfkey.org/schema/attribute/last-name.json"
                    },
                    {
                        id: "email",
                        label: "Email"
                        schemaId: "http://platform.selfkey.org/schema/attribute/email.json"
                    }
                ];
                $scope.onAuthResponse = (err, res, ui) => {
                    console.log('OnAuthResponse', err, res, ui);
                }
            }]);
```

**Usage In Code**:

`<lws-button website="website" attributes="attributes" root-endpoint="rootEndpoint" on-auth-response="onAuthResponse(err,res,ui)"></lws-button>`


**CDN**

Include the following script on your webpage:

`<script src="http://unpkg.com/angular@1.6.10/angular.min.js"></script>
<script src="https://unpkg.com/lws-angularjs-client@1.0.0-beta.26/dist/lws-angularjs-client.min.js"></script>`


**Usage In Code**:

```Shell

<div ng-controller="login">
        <lws-button website="website" attributes="attributes" root-endpoint="rootEndpoint" on-auth-response="onAuthResponse(err,res,ui)"></lws-button>
</div>


<script type="text/javascript>


angular.module('lwsExample', ['lwsSdk'])
            .controller('login', ['$scope', ($scope) => {
                $scope.website = {
                    name: 'LWS Example',
                    url: 'http://localhost:3031/',
                    termsUrl: 'http://localhost:3031/terms.html',
                    policyUrl: 'http://localhost:3031/policy.html',
                };
                $scope.rootEndpoint = 'http://localhost:3030/api/v1/selfkey',
                $scope.attributes = [
                    {
                        id: "first_name",
                        label: "First Name",
                        schemaId: "http://platform.selfkey.org/schema/attribute/first-name.json"
                    },
                    {
                        id: "last_name",
                        label: "Last Name",
                        schemaId: "http://platform.selfkey.org/schema/attribute/last-name.json"
                    },
                    {
                        id: "email",
                        label: "Email"
                        schemaId: "http://platform.selfkey.org/schema/attribute/email.json"
                    }
                ];
                $scope.onAuthResponse = (err, res, ui) => {
                    console.log('OnAuthResponse', err, res, ui);
                }
            }]);


</script>


```






## 3. React Client

URL: https://www.npmjs.com/package/lws-react-client

### Sample Integration

* https://github.com/SelfKeyFoundation/selfkey-js-client/tree/master/packages/react/example
* NOTE: This is a sample integration, the API may be further updated since then.

**Usage**

NPM with webpack or similar tools

**Install With NPM**

`npm install lws-react-client --save`

**Usage in Code**

`import { LWSButton } from 'lws-react-client';


const config = {
    website: {
        name: 'LWS Example',
        url: 'http://localhost:3032/',
        termsUrl: 'http://localhost:3030/terms.html',
        policyUrl: 'http://localhost:3030/policy.html'
    },
    rootEndpoint: 'http://localhost:3030/api/v1/selfkey',
    attributes: [
        {
            id: 'first_name',
            label: 'First Name',
            schemaId: 'http://platform.selfkey.org/schema/attribute/first-name.json'
        },
        {
            id: 'last_name',
            label: 'Last Name',
            schemaId: 'http://platform.selfkey.org/schema/attribute/last-name.json'
        },
        {
            id: 'email',
            label: 'Email',
            schemaId: 'http://platform.selfkey.org/schema/attribute/email.json'
        }
    ]
};
ReactDOM.render((<LWSButton />), document.getElementById('root'))`


**CDN**

Include the following script in your webpage:

`<script src="http://unpkg.com/react@16.5.0/umd/react.production.min.js"></script>
<script src="http://unpkg.com/react-dom@16.0.0/umd/react-dom.production.min.js"></script>
<script src="https://unpkg.com/lws-react-client@1.0.0-beta.26/dist/lws-react-client.min.js"></script>`


**Usage in Code**

####

```shell

<div ng-controller="login">
        <lws-button website="website" attributes="attributes" root-endpoint="rootEndpoint" on-auth-response="onAuthResponse(err,res,ui)"></lws-button>
</div>


<script>
            ReactDOM.render(
                React.createElement(lwsReact.LWSButton, {
                    website: {
                        name: 'LWS Example',
                        url: 'http://localhost:3032/',
                        termsUrl: 'http://localhost:3030/terms.html',
                        policyUrl: 'http://localhost:3030/policy.html'
                    },
                    rootEndpoint: 'http://localhost:3030/api/v1/selfkey',
                    attributes: [
                        {
                            id: 'first_name',
                            label: 'First Name',
                            attribute:
                                'http://platform.selfkey.org/schema/attribute/first-name.json'
                        },
                        {
                            id: 'last_name',
                            label: 'Last Name',
                            attribute: 'http://platform.selfkey.org/schema/attribute/last-name.json'
                        },
                        {
                            id: 'email',
                            label: 'Email',
                            schemaId: 'http://platform.selfkey.org/schema/attribute/email.json'
                        }
                    ]
                }),
                document.getElementById('root')
            );
 </script>

```





## 4. Vue Client

URL: https://www.npmjs.com/package/lws-vue-client

### Sample Integration

* https://github.com/SelfKeyFoundation/selfkey-js-client/tree/master/packages/vue/example
* NOTE: This is a sample integration, the API may be further updated since then.

**Usage**
NPM with webpack or similar tools

**Install With NPM**

`npm install lws-vue-client --save`

**Usage in Code**

```vue

require('lws-veu-client');

new Vue({
            el: '#root',
            data: {
                website: {
                    name: 'LWS Example',
                    url: 'http://localhost:3033/',
                    termsUrl: 'http://localhost:3030/terms.html',
                    policyUrl: 'http://localhost:3030/policy.html'
                },
                rootEndpoint: 'http://localhost:3030/api/v1/selfkey',
                attributes: [
                    {
                        id: "first_name",
                        label: "First Name",
                        schemaId: "http://platform.selfkey.org/schema/attribute/first-name.json"
                    },
                    {
                        id: "last_name",
                        label: "Last Name",
                        attribute: "http://platform.selfkey.org/schema/attribute/last-name.json"
                    }
                ],
            }
        });

```

**Usage in Code**

`<lws-button v-bind:website="website" v-bind:attributes="attributes" v-bind:root-endpoint="rootEndpoint"></lws-button>`


**CDN**

Include the following script in your webpage:

**Include Tag in Page**

`<script src="http://unpkg.com/vue@2.5.17/dist/vue.js"></script>
<script src="https://unpkg.com/lws-vue-client@1.0.0-beta.26/dist/lws-vue-client.min.js"></script>`

**Usage in Code**

####

```vue

<div id="root">
   <lws-button v-bind:website="website" v-bind:attributes="attributes" v-bind:root-endpoint="rootEndpoint"></lws-button>
</div>

<script type="text/javascript>

new Vue({
            el: '#root',
            data: {
                website: {
                    name: 'LWS Example',
                    url: 'http://localhost:3033/',
                    termsUrl: 'http://localhost:3030/terms.html',
                    policyUrl: 'http://localhost:3030/policy.html'
                },
                rootEndpoint: 'http://localhost:3030/api/v1/selfkey',
                attributes: [
                    {
                        id: "first_name",
                        label: "First Name",
                        schemaId: "http://platform.selfkey.org/schema/attribute/first-name.json"
                    },
                    {
                        id: "last_name",
                        label: "Last Name",
                        attribute: "http://platform.selfkey.org/schema/attribute/last-name.json"
                    }
                ],
            }
        });

</script>

```


## Node.JS

TBD by SelfKey Team  

## ASP.NET

TBD by SelfKey Team  

## SelfKey Service

TBD by SelfKey Team  


# E. Authentication

## Overview

The purpose of this function is to prove the user has ownership over a Decentralized Identifier (DID) presented for authentication. To do this, we issue a **"Challenge-Response"** protocol to cryptographically prove ownership via private key. For Details about API endpoints, please consult: [REST API Spec](#f-rest-api-spec).

<aside class="notice">Note: All communications MUST be done via secure SSL connection.</aside>

## Part 1: Challenge-Response Protocol

1. The SelfKey Identity Wallet requests a unique nonce from the your website and sends the Ethereum public key.
2. Your website responds with a Challenge JWT Token containing the public key in subject and nonce claim.
3. The wallet receives the Challenge Token, decodes it and extracts the nonce.
4. The wallet creates a signature of the nonce signed with it's private key.
5. The wallet replies to your website with the challenge JWT token and signature.
6. Your website verifies that signature corresponds to the public key and nonce inside the JWT challenge token.
7. Your website replies to the wallet by issuing a Wallet JWT token.
8. The SelfKey Identity Wallet uses the "Wallet JWT Token" to perform other requests to your website.


## Part 2: JWT-JSON Web token

How To Implement JWT Tokens:

* [JSON Web Token: Wikipedia] (https://en.wikipedia.org/wiki/JSON_Web_Token)
* [JWT.io] (https://jwt.io/)
* [JWT Handbook] (https://auth0.com/resources/ebooks/jwt-handbook)
* [Auth0 JWT Docs] (https://auth0.com/docs/jwt)

### Allowed Algorithms
* **HMAC** - Default
* **RSA** - Suitable for multi server authentication (STILL IN DEVELOPMENT)



## Part 3: Challenge Token

Besides several requirements below, you are free to include any data in your token for verification.

Required Claims:

* **sub**: (Subject) The wallet's public key
* **iat**: (Issued At) the epoch timestamp that the JWT was issued at
* **exp**: (Expiration)the epoch timestamp at which the JWT expires
* **nonce**: (Number used Once) a random string of bytes (base64-encoded) which must be signed in order to authenticate
* **typ**: "IDW_CHALLANGE"
* Recommended token expiration time: 30 min

## Part 4: Wallet Token

Besides several requirements below, you are free to include any data in your token for verification.

Required Claims:

* **sub**: (Subject) The wallet's public key
* **iat**: (Issued At) the epoch timestamp that the JWT was issued at
* **exp**: (Expiration)the epoch timestamp at which the JWT expires
* **typ**: "IDW_ACCESS"
* Recommended token expiration time: 60 min

## Part 5: How To Verify Wallet Token On Other Servers

* JWT token can be verified on other servers, not just one.
* This allows our API to reside in several different services, not necessary all endpoints in one.
* For this to work, you must initialize your JWT verification logic with a shared secret key between the servers.
* A better approach would be to use RS256 algorithm, and have your private key be accessible only to the server that hosts the challenge/response endpoint.
* Afterwards, any other server that needs to verify it can use the public key.






# F. REST API Spec

## Overview

Our REST API is broken down into three parts:

1. **Authentication**: Verifying user ownership of a Decentralized Identifier (DID) via a challenge-response protocol.
2. **SelfKey Extension**: Bridge between the SelfKey Wallet and your website for authentication.
3. **KYC for New Users**:  Verify identities from existing integrated templates with our compliance tool KYC-Chain.


<aside class="notice">
NOTE: All communications must be done via a secure SSL connection.
</aside>

## Headers Sent By SelfKey Identity wallet

### User-Agent
* For each API request, the SelfKey Identity Wallet sends the following user agent: SelfKeyIDW/[WALLET_VERSION] where WALLET_VERSION is a semver version of our application.
* Example:  User-Agent: SelfKeyIDW/1.0.0-beta

### Origin
* For API requests, the SelfKey Identity Wallet will send an 'Origin' header indicating who initialized the request.
* The default value is IDW indicating that the request was initialized by the SelfKey Identity Wallet.
* For our browser plugin [SelfKey Extension](https://chrome.google.com/webstore/detail/selfkey-extension/fmmadhehohahcpnjjkbdajimilceilcd), it will rely on the SelfKey Identity Wallet to determine which side initialized the request, and the Origin header will be set to this value.
* Example: "Origin: IDW" or "Origin: https://confluence.kyc-chain.com"




## 1: Authentication
* The goal of this function is to prove that the user has ownership over the presented Decentralized Identifier (DID).
* This is done through a cryptographic challenge-response protocol as detailed below.


### Challenge

Overview: This request is dispatched by the SelfKey Identity Wallet to start establishing the authentication session with your website.

### Request


`GET /auth/challenge/${publicKey}`


URL Params:

* publicKey - standard Ethereum public key with (Note 0x prefix is required)

Example:

`GET /auth/challenge/0x3a1076bf45ab87712ad64ccb3b10217737f7faacbf2872e88fdd9a537d8fe266`

Headers:

* User-Agent,
* Origin,
* Accept: application/json

### Response

Success (Status Code: 200)

Body:

JSON payload containing one key 'jwt'. It will contain the challenge token.

`{
  "jwt":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIweDc0NWZhYmQyZWZkYmY5ZGViMzE2NDJiMjA1NGVlMmJjNzg2ZWJlYTA5NmQzNmMwYjFiMzA1ZWRhYWY5ODEzYzZiNDA1MWEzMzQyNjZjOWY0MGI3MTQzODFjMDNkYTVkYTMxNWVjMjA3MDAwZmE3YmI3NDg2OGE1ZTYxNDIxZTMxIiwiaWF0IjoxNTE2MjM5MDIyLCJub25jZSI6IjlWeDFRUmswbzk2UGNKcDhXbnhvNy9DMjdCQnJ0aFdHZTlPcUZ6OGRwa2VjbVNVQ0Q3RnJQNUhpZW5vWUg3OTN1cG1nYmtLNFY3c0JMKzR6YWJkQjJRPT0iLCJzY29wZSI6ImF1dGgvY2hhbGxlbmdlIn0.5V2BBI53C0NOzmaIcvNNg_04O6MmTQc4oFvRJ8vf5i0"
  }`



Error: Invalid Public Key (Status Code: 422)

Body:

`{ "code": "invalid_key" "message": "Invalid public key"}`

### Challenge Reply

* Request is dispatched by the SelfKey Identity Wallet to verify ownership of an Ethereum private key.
* Payload is ECDA signature for the provided nonce. There are five types of responses:
* 1) Success, 2) Error - Bad Request, 3) Error - Not Authorized, 4) Error - Forbidden, and 5) Error - Bad Payload.
* Hardware Wallets: For users with Trezor or Ledger, they will have to manually confirm on devices for ECDA signatures.


Request:

`POST /auth/challenge/`

Headers:

* User-Agent,
* Origin,
* Accept: application/json
* Authorization: challenge token received from challenge endpoint

Body:

* JSON payload containing one key 'signature'.
* It will contain an ECDA signature generated by signing the nonce with Ethereum private key.
* Represented as hex (rpc sig).

`{"signature": "0xf62e386b48761c61d5e0a54d90ba6bea1ee9648d9e26f1301e9be2306843190357c1d1c915244aa171bc34b0c2c6b66ad546ef651eeaa7add8335675e3e5454601"}`

### Responses


Success (Status Code: 200)

Body:

A JSON payload containing one key 'jwt. It will contain the wallet token.

`{  "jwt": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIweDc0NWZhYmQyZWZkYmY5ZGViMzE2NDJiMjA1NGVlMmJjNzg2ZWJlYTA5NmQzNmMwYjFiMzA1ZWRhYWY5ODEzYzZiNDA1MWEzMzQyNjZjOWY0MGI3MTQzODFjMDNkYTVkYTMxNWVjMjA3MDAwZmE3YmI3NDg2OGE1ZTYxNDIxZTMxIiwiaWF0IjoxNTE2MjM5MDIyLCJub25jZSI6IjlWeDFRUmswbzk2UGNKcDhXbnhvNy9DMjdCQnJ0aFdHZTlPcUZ6OGRwa2VjbVNVQ0Q3RnJQNUhpZW5vWUg3OTN1cG1nYmtLNFY3c0JMKzR6YWJkQjJRPT0iLCJzY29wZSI6ImF1dGgvY2hhbGxlbmdlIn0.5V2BBI53C0NOzmaIcvNNg_04O6MmTQc4oFvRJ8vf5i0"}
`

Error - Bad Request (Status Code: 400)

`{
  "code": "token_missing",
  "message": "Missing authorization header"
}`

Error - Not Authorized (Status Code: 401)

`{ "code": "token_invalid", "message": "Invalid token: Missing nonce claim"}`

`{"code": "token_invalid","message": "Malformed authorization header"}`

Error - Forbidden (Status Code: 403)

`{"code": "forbidden","message": "Insufficient permissions"}`

Error - Bad Payload (Status Code: 422)

`{"code": "signature_invalid","message": "Invalid signature"}`

`{"code": "signature_missing","message": "Missing signature"}`


## 2: SelfKey Extension

### Create User File
`POST /users/files`

### Request

Headers

* User-Agent
* Origin
* Accept: application/json
* Authorization: wallet token
* Content-Type: multipart/form-data

Body: Binary File Upload

### Response


Success (Status Code: 200)

Body: JSON object with single key "id" representing the created file id
`{
   "id": "file-id-1"
}`


Error - Bad Request (Status Code: 400)

`{
  "code": "token_missing",
  "message": "Missing authorization header"
}`


Error - Not Authorized (Status Code: 401)

`{
  "code": "token_invalid",
  "message": "Invalid token: Missing nonce claim"
}`

`{
  "code": "token_invalid",
  "message": "Malformed authorization header"
}`


Error - Forbidden (Status Code: 403)

`{
  "code": "forbidden",
  "message": "Insufficient permissions"
}`


Error - Bad Payload (Status Code: 422)

`{
  "code": "file_invalid",
  "message": "Should be a single file"
}`



### Create User

```Javascript
[
    { "id": "first_name", "schemaId": "http://platform.selfkey.org/schema/attribute/first-name.json", "value": "First" },
    { "id": "passport", "schemaId": "https://platform.selfkey.org/schema/attribute/passport.json", "value": {
         "image": { "mimeType": "image/jpg", "size": 3000000000, "content": "file-id-1"},
         "issued": "15-05-2019",
         "expires": "16-05-2019",
         "selfie": { "mimeType": "image/jpg", "size": "28525854564", "content": "file-id-2"},
     } },
     {
        "id": "nationality",
        "schemaId": "https://platform.selfkey.org/schema/attribute/nationality.json",
        "value": { "country": "AT", "denonym": "Austrian"}
     }
]
```




**Request**:

`POST /users`


Headers:

* User-Agent,
* Origin,
* Accept: application/json
* Authorization: wallet token.

Body:

JSON object containing ID attributes from the SelfKey Identity Wallet. Each ID attribute contains at least the following keys:

* **id** (optional): provided in SelfKey Extension config, used for attributing internal application structure
* **schemaId**: The id of one of the supported id attributes. Can be found here: https://platform.selfkey.org/repository.json
* **value**: The value of the attribute.

Note, document attributes should have all files uploaded first via the files endpoint and their content replaced by id.


### Response

Success (Status Code: 201 – Created With No Body)

Error – Bad Request (Status Code: 422)

`{
  "code": "bad_request",
  "message": "Error validating attributes"
}`


### Get User Token



**Request**:

`GET /users/token`

Headers:

* User-Agent,
* Origin,
* Accept: application/json
* Authorization: wallet token.

Success (Status Code: 200)

Body:

JSON object, structure is defined by relying party. This object is passed back to your website.

*Example*:

`{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIweDc0NWZhYmQyZWZkYmY5ZGViMzE2NDJiMjA1NGVlMmJjNzg2ZWJlYTA5NmQzNmMwYjFiMzA1ZWRhYWY5ODEzYzZiNDA1MWEzMzQyNjZjOWY0MGI3MTQzODFjMDNkYTVkYTMxNWVjMjA3MDAwZmE3YmI3NDg2OGE1ZTYxNDIxZTMxIiwic2NvcGUiOiJhdXRoL2xvZ2luIiwiaWF0IjoxNTQ3NjIyNDA1fQ.xajZn2UmKtCT1WeLleye8DoCCcYnbavVnZ5TZ0bK7CM"
}`

If your website waits for the response to be parsed and acted upon automatically on client side, the payload should contain one of these two keys:

* "token" – Will be posted to [Login Endpoint]
* "redirectTo" – will cause a redirect to the provided URL



Error - Bad Request (Status Code: 400)

`{
  "code": "token_missing",
  "message": "Missing authorization header"
}`


Error - Not Authorized (Status Code: 401)

`{
  "code": "token_invalid",
  "message": "Invalid token: Missing nonce claim"
}`


`{
  "code": "token_invalid",
  "message": "Malformed authorization header"
}`



Error - Forbidden (Status Code: 403)

Body:

`{
  "code": "forbidden",
  "message": "Insufficient permissions"
}`


### Login Endpoint

**Request**:

`POST /login
`
Headers:

* User-Agent – provided by browser
* Origin – provided by browser
* Accept: application/json


Body:

JSON object containing the payload received from /users/token endpoint

`{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIweDc0NWZhYmQyZWZkYmY5ZGViMzE2NDJiMjA1NGVlMmJjNzg2ZWJlYTA5NmQzNmMwYjFiMzA1ZWRhYWY5ODEzYzZiNDA1MWEzMzQyNjZjOWY0MGI3MTQzODFjMDNkYTVkYTMxNWVjMjA3MDAwZmE3YmI3NDg2OGE1ZTYxNDIxZTMxIiwic2NvcGUiOiJhdXRoL2xvZ2luIiwiaWF0IjoxNTQ3NjIyNDA1fQ.xajZn2UmKtCT1WeLleye8DoCCcYnbavVnZ5TZ0bK7CM"
}`


**Response**:

Success (Status Code: 200)

Body: JSON object containing 'redirectTo' key

Example:

`{
  "redirectTo": "/success.html"
}`

`{
  "redirectTo": "/login-failed.html"
}`



## 3: KYC (SelfKey Marketplace)

### List Templates  

```JavaScript
[
    {
        "name": "Token Sale Signup for Individuals",
        "description": "For individuals wishing to participate in the Example Co token sale.",
        "templateId": "507f1f77bcf86cd799439011",
    },
    {
        "name": "Token Sale Signup for Companies",
        "description": "For companies, trusts or other organizations wishing to participate in the Example Co token sale.",
        "templateId": "534bad4b8342419e5a94b1d2",

    }
]
```

* These templates are created to run identity verification checks based on submitted attributes or documents.
* Returns a list of templates for the relying party, and this endpoint does not require Authorization.

**Request**:

`GET /templates`

Headers

* User-Agent,
* Origin,
* Accept: application/json


**Response**:

Success (Status Code: 200)





### Get Template Details

```javascript
`
{
  "id": "5c6619ae1ea6440111989852",
  "description": "Standard Attributes and Documents",
  "atributes": [
    {
      "id": "5c4e6edda58d2900401ba61b",
      "required": true,
      "schemaId": "http://platform.selfkey.org/schema/attribute/first-name.json"
    },
    {
      "id": "5c4e6efaa58d2900401ba61d",
      "required": true,
      "schemaId": "http://platform.selfkey.org/schema/attribute/last-name.json "
    },
    {
      "id": "5c511c64c7315f003ecfe2dc",
      "required": true,
      "schemaId": "http://platform.selfkey.org/schema/attribute/email.json"
    },
    {
      "id": "5c4e6e6ba58d2900401ba615",
      "required": true,
      "schemaId": "http://platform.selfkey.org/schema/attribute/bank-statement.json"
    },
    {
      "id": "5c4e6e89a58d2900401ba617",
      "required": false,
      "schemaId": "http://platform.selfkey.org/schema/attribute/bank-statement.json"
    },
    {
      "id": "5c4e6ea6a58d2900401ba619",
      "required": true,
      "schemaId": "http://platform.selfkey.org/schema/attribute/passport.json"
    }
  ],
  "name": "Standard Attributes"
`
```




Returns a specific template details.

**Request**:

`GET /templates/${templateId}`

URL params:

* templateId: the id of the requested template

Headers

* User-Agent,
* Origin,
* Accept: application/json


**Response**:

Success (Status Code: 200)


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>


### Create KYC File

`POST /files`


**Request**:

Headers:

* User-Agent
* Origin
* Accept: application/json
* Authorization: wallet token
* Content-Type: multipart/form-data

Body: binary file upload


**Response**:

Success (Status Code: 200)

Body: JSON object with single key "id" representing the created file id

*Example*:

`{
   "id": "file-id-1"
}`



Error - Bad Request (Status Code: 400)

`{
  "code": "token_missing",
  "message": "Missing authorization header"
}`


Error - Not Authorized (Status Code: 401)

`{
  "code": "token_invalid",
  "message": "Invalid token: Missing nonce claim"
}`

`{
  "code": "token_invalid",
  "message": "Malformed authorization header"
}`


Error - Forbidden (Status Code: 403)

Body:

`{
  "code": "forbidden",
  "message": "Insufficient permissions"
}`


Error - Bad Payload (Status Code: 422)

*Example*:

`{
  "code": "file_invalid",
  "message": "Should be a single file"
}`


### GET User File

`GET /users/files/${fileId}`


**Request**:

URL params:

* fileId

Headers:

* User-Agent
* Origin
* Accept: application/json
* Authorization: wallet token


Success (Status Code: 200)

`{ url: 'https://myurl.com/documents/23123' }`


Error - Not Found (Status Code: 404)

`{ code: 'not_found', message: 'File not found' }`


Error - Not Authorized (Status Code: 401)

Body

`{
  "code": "token_invalid",
  "message": "Invalid token: Missing nonce claim"
}`

`{
  "code": "token_invalid",
  "message": "Malformed authorization header"
}`



Error - Forbidden (Status Code: 403)

Body:

`{
  "code": "forbidden",
  "message": "Insufficient permissions"
}`


### Create KYC Application

```JavaScript

{
  "templateId": "5c6533c440e7080070dda1f4",
  "attributes": [
    {
      "id": "5c657861e97908003ec70d19",
      "schemaId": "http://platform.selfkey.org/schema/attribute/first-name.json",
      "data": "John"
    },
    {
      "id": "5c657880e97908003ec70d1b",
      "schemaId": "http://platform.selfkey.org/schema/attribute/last-name.json",
      "data": "Doe"
    },
    {
      "id": "5c657898e97908003ec70d1d",
      "schemaId": "http://platform.selfkey.org/schema/attribute/email.json",
      "data": "john.doe@domain.com"
    },
    {
      "id": "5c6578c4e97908003ec70d1f",
      "schemaId": "http://platform.selfkey.org/schema/attribute/passport.json",
      "data": {
        "image": {
          "mimeType": "image/png",
          "size": 50000,
          "content": "5c6619ae1ea6440111989852"
        },
        "issued": "2019-02-19",
        "expires": "2029-02-19"
      }
    }
  ]
}
```




`POST /applications`

**Request**:

Headers:

* User-Agent
* Origin
* Accept: application/json
* Authorization: wallet token

Body: JSON object containing application object

Application object will contain:

* templateId – the id of a template which was used to fill application object
* attributes – a list of id attributes, each attribute contains
* id: internal KYC system id assigned to the attribute (from template)
* schemaId: the id of the schema filled (list is available in https://platform.selfkey.org/repository.json)
* data: the data filled according for the schema for this attribute



**Response**:

Success (Status Code: 200)

Body: JSON object with single key "id" representing the created file id

Example:

`{
  "id": "5c6623537406490150f93b5f",
  "applicationUrl": "http://localhost/v2/applications/5c6623537406490150f93b5f"
}`



Error - Bad Request (Status Code: 400)

`{
  "code": "token_missing",
  "message": "Missing authorization header"
}`


Error - Not Authorized (Status Code: 401)

Body

`{
  "code": "token_invalid",
  "message": "Invalid token: Missing nonce claim"
}`

`{
  "code": "token_invalid",
  "message": "Malformed authorization header"
}`


Error - Forbidden (Status Code: 403)

Body:

`{
  "code": "forbidden",
  "message": "Insufficient permissions"
}`


Error - Bad Payload (Status Code: 422, Several Errors Possible)

Example:

`{
  "code": "file_invalid",
  "message": "Should be a single file"
}`


### List KYC Applications

```JavaScript
[
  {
    "id": "5c6e013704fb92059af59147",
    "template": "5c6dfa25b0745105685253bd",
    "statusName": "In Progress",
    "currentStatus": 6
  },
  {
    "id": "5c6e17dd069cfc060b256802",
    "template": "5c6dfa25b0745105685253bd",
    "statusName": "In Progress",
    "currentStatus": 6
  }
]
```

`GET /applications`


**Request**:

Headers:

* User-Agent
* Origin
* Accept: application/json
* Authorization: wallet token



**Response**:

Success (Status Code: 200)

Body: JSON object containing a list of application objects




Error - Bad Request (Status Code: 400)

`{
  "code": "token_missing",
  "message": "Missing authorization header"
}`


Error - Not Authorized (Status Code: 401)

Body

`{
  "code": "token_invalid",
  "message": "Invalid token: Missing nonce claim"
}`

`{
  "code": "token_invalid",
  "message": "Malformed authorization header"
}`




Error - Forbidden (Status Code: 403)

Body

`{
  "code": "forbidden",
  "message": "Insufficient permissions"
}`



### Update KYC Applications

```JavaScript
{
  "templateId": "5c6533c440e7080070dda1f4",
  "attributes": [
    {
      "id": "5c657861e97908003ec70d19",
      "schemaId": "http://platform.selfkey.org/schema/attribute/first-name.json",
      "data": "John"
    },
    {
      "id": "5c657880e97908003ec70d1b",
      "schemaId": "http://platform.selfkey.org/schema/attribute/last-name.json",
      "data": "Doe"
    },
    {
      "id": "5c657898e97908003ec70d1d",
      "schemaId": "http://platform.selfkey.org/schema/attribute/email.json",
      "data": "john.doe@domain.com"
    },
    {
      "id": "5c6578c4e97908003ec70d1f",
      "schemaId": "http://platform.selfkey.org/schema/attribute/passport.json",
      "data": {
        "image": {
          "mimeType": "image/png",
          "size": 50000,
          "content": "5c6619ae1ea6440111989852"
        },
        "issued": "2019-02-19",
        "expires": "2029-02-19"
      }
    }
  ]
}
```




`PATCH /applications/${applicationId}`

Takes attributes from payload and updates them inside application object on server

URL params:

* applicationId – The id of the application to update



**Request**:

Headers:

* User-Agent
* Origin
* Accept: application/json
* Authorization: wallet token

Body: JSON object containing application object

Application object will contain:

* templateId – the id of a template which was used to fill application object
* attributes – a list of id attributes, each attribute contains
* id: internal kyc system id assigned to the attribute ( from template)
* schemaId: the id of the schema filled (list is available in https://platform.selfkey.org/repository.json)
* data: the data filled according for the schema for this attribute




**Response**:

Success (Status Code: 204)

Error - Bad Request (Status Code: 400)

`{
  "code": "token_missing",
  "message": "Missing authorization header"
}`



Error - Not Authorized (Status Code: 401)

Body:

`{
  "code": "token_invalid",
  "message": "Invalid token: Missing nonce claim"
}`

`{
  "code": "token_invalid",
  "message": "Malformed authorization header"
}`


Error - Forbidden (Status Code: 403)

Body:

`{
  "code": "forbidden",
  "message": "Insufficient permissions"
}`



Error - Bad Payload (Status Code: 422, Several Errors Possible)

*Example*:

`{
  "message": "Attribute referenced files not found"
}`



### Get Application Details

```javascript
`{
  "id": "5c6e013704fb92059af59147",
  "payments": [],
  "template": "5c6dfa25b0745105685253bd",
  "statusName": "In Progress",
  "currentStatus": 6
}`
```

`GET /applications/${applicationId}`

Returns all available details about a specific application

URL params:

* applicationId – The id of the application.


**Request**

Headers:

* User-Agent
* Origin
* Accept: application/json
* Authorization: wallet token


**Response**

Success (Status Code: 200)

Body: JSON object containing a list of application objects


Error - Bad Request (Status Code: 400)

`{
  "code": "token_missing",
  "message": "Missing authorization header"
}`



Error - Not Authorized (Status Code: 401)

Body

`{
  "code": "token_invalid",
  "message": "Invalid token: Missing nonce claim"
}`

`{
  "code": "token_invalid",
  "message": "Malformed authorization header"
}`


Error - Forbidden (Status Code: 403)

Body:

`{
  "code": "forbidden",
  "message": "Insufficient permissions"
}`



### Create KYC Application Payment

`POST /applications/${applicationId}/payments`


**Request**

Headers:

* User-Agent
* Origin
* Accept: application/json
* Authorization: wallet token

Body: JSON object containing application payment

Application payment object will contain:

* transactionHash – the hash of an ethereum transaction

`{
  "transactionHash": "0x8b69a0ca303305a92d8d028704d65e4942b7ccc9a99917c8c9e940c9d57a9662"
}`


**Response**

Success (Status Code: 200)

####

```javascript
`{
  "createdAt": "2019-02-21T03:44:47.555Z",
  "id": "5c6e1eaf049ff100646cedd8",
  "transactionHash": "0x8b69a0ca303305a92d8d028704d65e4942b7ccc9a99917c8c9e940c9d57a9662"
}`
```


Body: JSON object with created payment details



Error - Bad Request (Status Code: 400)

`{
  "code": "token_missing",
  "message": "Missing authorization header"
}`


Error - Not Authorized (Status Code: 401)

Body

`{
  "code": "token_invalid",
  "message": "Invalid token: Missing nonce claim"
}`

`{
  "code": "token_invalid",
  "message": "Malformed authorization header"
}`


Error - Forbidden (Status Code: 403)

Body:

`{
  "code": "forbidden",
  "message": "Insufficient permissions"
}`

Error - Bad Payload (Status Code: 422, Several Errors Possible)

Example:

`{
  "message": "Transaction hash is missing"
}`
