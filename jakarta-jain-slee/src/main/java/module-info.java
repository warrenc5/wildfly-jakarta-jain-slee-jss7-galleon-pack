module mobi.mofokom.jakarta.jainslee {

    exports javax.slee;
    exports javax.slee.connection;
    exports javax.slee.facilities;
    exports javax.slee.management;
    exports javax.slee.nullactivity;
    exports javax.slee.profile;
    exports javax.slee.resource;
    exports javax.slee.serviceactivity;
    exports javax.slee.transaction;
    exports javax.slee.usage;

    requires jakarta.annotation;
    requires jakarta.cdi;
    requires jakarta.transaction;
    requires jakarta.resource;
    requires java.management;
    requires java.rmi;
}