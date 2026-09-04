Attempt to coordinate modern build distribution of 
  * JDK 17+ 
  * Wildfly 26.x.x
  * mobicents-jain-slee 
  * restcomm-jss7 stack
  * restcomm-jss7 resource adaptors
  * (other resource adaptors)
  * JACC/Elytron security for cli modules
  * Mofokom Jain Slee annotations support 

Wildfly 21 was a good stepping stone and can be removed once 26 is stable/tested
Wildfly 26 is the last JEE8 javax. version
Wildfly 39 requires major recoding/rework

There maybe other sensible Wildlfy target versions between 26 and 39


