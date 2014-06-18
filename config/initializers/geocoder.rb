Geocoder.configure(

# geocoding service (see below for supported options):
:lookup => :google,

#Proxy server
:http_proxy => ENV['QUOTAGUARD_URL'],

# geocoding service request timeout, in seconds (default 3):
:timeout => 5,

# set default units to kilometers:
:units => :km,

)
