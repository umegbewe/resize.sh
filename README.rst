resize.sh
=========
Shell script for resizing running AWS EBS Volumes

Usage:
------
Download
~~~~~~

::

    curl -oL https://raw.githubusercontent.com/umegbewe/resize.sh/main/resize.sh
    bash resize.sh or chmod +x resize.sh && ./resize.sh

Github
~~~~~~

::

    git clone https://github.com/umegbewe/resize.sh
    cd resize.sh
    bash resize.sh or chmod +x resize.sh && ./resize.sh


Some likely Errors
~~~~~~~~~~~~

::

    An error occurred (VolumeModificationRateExceeded) when calling the ModifyVolume operation: 
    You've reached the maximum modification rate per volume limit. Wait at least 6 hours between modifications per EBS volume.
    
If you reach the maximum volume modification rate per volume limit, you must wait at least six hours before applying further modifications to the affected EBS volume.

::

    An error occurred (InvalidParameterValue) when calling the ModifyVolume operation: 
    New size cannot be smaller than existing size.
    
You inputed a size smaller than the current size of the EBS Volume
    
::

    invalid literal for int() with base 10: 'decimal'
    
SIZE only takes integer values, please input accordingly in GiBs E.g 10, 20, 30 etc 


I found a bug or something not working right? Please submit a pull request or reach to me via mail nwebedujunior55 at gmail dot com
    
    
