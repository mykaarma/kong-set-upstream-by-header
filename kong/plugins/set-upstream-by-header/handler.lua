local SetUpstreamByHeaderHandler = {
    VERSION = "1.0.0",
    PRIORITY = 850
}


function find_upstream_by_header_value(header_value, map, matching)
    if matching == "exact" then
        if map[header_value] then
            return map[header_value]
        end
    elseif matching == "regex" then
        for hval, upstream in pairs(map) do
            if string.match(header_value, hval) then
                return upstream
            end
        end
    end
end

function SetUpstreamByHeaderHandler:access(conf)
    local header_value = kong.request.get_header(conf.header)
    local upstream
    if header_value then
        upstream = find_upstream_by_header_value(header_value, conf.header_value_and_upstream_map, conf.header_matching)
        if upstream==nil then
            kong.log.err("Upstream not found corresponding to the provided header value. Routing request to the default upstream")
        end
    else
        kong.log.warn(conf.header.." header not found. Routing request to the default upstream")
    end
    if upstream==nil then
        upstream = conf.default_upstream
    end
    kong.response.set_header("x-kong-upstream", upstream)
    kong.service.set_upstream(upstream)
end

return SetUpstreamByHeaderHandler
