Shell-ShellNS-Result
================================

> [Aeon Digital](http://www.aeondigital.com.br)  
> rianna@aeondigital.com.br

&nbsp;

``Shell Namespace Result`` stores information about the execution of a function 
or process for further processing. Especially useful when you want the result 
of a function not to be displayed immediately or when you want a function to 
have multiple return values.


&nbsp;
&nbsp;


________________________________________________________________________________

## Standalone installation and execution

If you wish to use this package in standalone mode, please follow the 
guidelines below:  

``` shell
# Download with CURL
curl -o "shellns_result_standalone.sh" \
"https://raw.githubusercontent.com/AeonDigital/Shell-ShellNS-Result/refs/heads/main/standalone.sh"

# Give execution permissions
chmod +x "shellns_result_standalone.sh"

# Load
. "shellns_result_standalone.sh"
```


&nbsp;
&nbsp;


________________________________________________________________________________

## How to use

### Set and shows Results

**Examples:**

``` shell
# Set
# $1    : Name of the function performed.
# $2    : Function output status.
# #3... : All arguments from here on out are printable results 
#         of the original function.
shellNS_result_set "fnName" "0" "value1" "value2" "value3"


# Shows the total stored values
shellNS_result_count
3


# Shows the first value of list
# $1 : [ optional ] index of the value to be returned.
#      if empty, shows the '0' index position.
# 
# Note that the status recorded in the 'set' function is also returned when 
# evoking the 'show' function, so if it is a status other than '0', your 
# terminal will also report an error.
shellNS_result_show
value1



# Shows another values stored
shellNS_result_show 1
value2
shellNS_result_show 2
value3



# If an invalid position is passed, status 255 will be returned.
shellNS_result_show 3
echo $?
255



# Reset the current values
# If you use the 'set' function, the previously defined values will be 
# overwritten.
shellNS_result_reset
shellNS_result_count
0
```


&nbsp;
&nbsp;

________________________________________________________________________________

## Licence

This project uses the [MIT License](LICENCE.md).
