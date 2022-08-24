# kong-set-upstream-by-header
This plugin sets the upstream of the request in Kong on the basis of header.

## Installation

**Using Luarocks:**<br/>
The plugin can be installed by using the following command:<br/>
`luarocks install set-upstream-by-header`

**Using source:**<br/>
`git clone https://github.com/mykaarma/kong-set-upstream-by-header`<br/>
`cd kong-set-upstream-by-header`<br/>
`luarocks make`<br/>

Then, add the plugin to the `plugins` key in `kong.conf` file.<br/>
`plugins=set-upstream-by-header`


## Parameters

Here's a list of all the parameters which can be used in this plugin's configuration:

| Parameter | Required | Description |
| --- 						| --- | --- |
| `name` 					                        |   true    | The name of the plugin to use, in this case `set-upstream-by-header` |
| `config.header` 	                                |   true    | The name of the header whose is need to be considered for routing |
| `config.header_value_and_upstream_map` 		    |   true    | The mapping of the header value with the desired upstream to which th e request is to be routed. It should be provided as a map. |
| `header_matching`                                 |   true    | It takes one of the following values: `exact` or `regex`.<br/> If it is set to `exact`, then the exact header value should be provided in the mapping.<br/> If it is set to `regex`, then the regex of the header value should be provied in the mapping. |
| `default_upstream`                                |   true    | If the given header is not present or matched, then the request is routed to this upstream.   |


## How to apply?

The plugin can be applied using Kong Admin API as follows:

curl -X POST \<Kong-Admin-API-URL\>/plugins \ <br/>
--data "name=set-upstream-by-header" \ <br/>
--data "config.header=\<header\>" \ <br/>
--data "config.header_value_and_upstream_map.\<header-value-1\>=\<upstream-1\>" \ <br/>
--data "config.header_value_and_upstream_map.\<header-value-2\>=\<upstream-2\>" \ <br/>
--data "config.header_matching=regex" \ <br/>
--data "config.default_upstream=\<default-upstream\>
