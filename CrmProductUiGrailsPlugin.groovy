class CrmProductUiGrailsPlugin {
    // Dependency group
    def groupId = "grails.crm"
    // the plugin version
    def version = "1.1"
    // the version or versions of Grails the plugin is designed for
    def grailsVersion = "2.0 > *"
    // the other plugins this plugin depends on
    def dependsOn = [:]
    def loadAfter = ['crmContact']
    // resources that are excluded from plugin packaging
    def pluginExcludes = [
            "grails-app/conf/ApplicationResources.groovy",
            "src/groovy/grails/plugins/crm/product/TestSecurityDelegate.groovy",
            "grails-app/views/error.gsp"
    ]

    def title = "Grails CRM Product Plugin"
    def author = "Goran Ehrsson"
    def authorEmail = "goran@technipelago.se"
    def description = '''\
Provides (admin) user interface for product/item management in Grails CRM
'''

    // URL to the plugin's documentation
    def documentation = "http://grails.org/plugin/crm-product-ui"
    def license = "APACHE"
    def organization = [name: "Technipelago AB", url: "http://www.technipelago.se/"]
    def issueManagement = [system: "github", url: "https://github.com/goeh/grails-crm-product-ui/issues"]
    def scm = [url: "https://github.com/goeh/grails-crm-product-ui"]

    def features = {
        crmProduct {
            description "Product Catalogue"
            link controller: "crmProduct", action: "index"
            permissions {
                guest "crmProduct:index,list,show"
                user "crmProduct:*"
                admin "crmProduct,crmProductGroup,crmPriceList:*"
            }
            hidden true
        }
    }
/*
    def doWithApplicationContext = { applicationContext ->
        def crmCoreService = applicationContext.crmCoreService
        def crmPluginService = applicationContext.crmPluginService
        def crmContentService = applicationContext.containsBean('crmContentService') ? applicationContext.crmContentService : null
        if (crmContentService) {
            crmPluginService.registerView('crmProduct', 'show', 'tabs',
                    [id: "resources", index: 250, permission: "crmProduct:show", label: "Media", template: '/crmProduct/resources', plugin: "crm-product", model: {
                        def result = crmContentService.findResourcesByReference(crmProduct, [sort: 'title', order: 'asc'])
                        return [list: result, totalCount: result.totalCount, reference: crmCoreService.getReferenceIdentifier(crmProduct)]
                    }]
            )
        }
    }
*/
}
