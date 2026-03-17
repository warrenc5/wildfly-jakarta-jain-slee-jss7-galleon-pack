Attempt to coordinate modern build distribution of 
  * JDK 17+ 25+
  * Wildfly 26.x.x 39.x.x +
  * jain-slee
  * mobicents-jain-slee 
  * restcomm-jss7 stack
  * restcomm-jss7 resource adaptors
  * (other resource adaptors) http 
  * JACC/Elytron security for cli modules
  * Mofokom Jain Slee annotations support 


Branched pre Jakarta

Wildfly 21 was a good stepping stone and can be removed once 26 is stable/tested
Wildfly 26 is the last JEE8 javax. version

Wildfly 39 requires major recoding/rework most has been done locally

TODO copy artifacts/scripts to build distro using Galleon Tasks 
    * ss7 cli
    * resource adapters deployments
    * support deployments restcomm.war
