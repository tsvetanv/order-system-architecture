workspace "Order Processing System" "C4 model for the Order Processing System demo" {

    model {

        # ============================
        # CONTEXT MODEL
        # ============================

        customer = person "Customer" "Places and tracks orders"

        ops = softwareSystem "Order Processing System" "Manages the lifecycle of customer orders" {

            # ============================
            # CONTAINER MODEL
            # ============================

            orderApi = container "Order API" "Handles HTTP requests & routing" "REST API / Spring Boot"
            orderService = container "Order Service" "Order workflows & business logic" "Java / Spring Boot"
            orderDb = container "Order Database" "Stores orders, state & audit trail" "PostgreSQL"
            integrationService = container "Integration Service" "Adapters to external systems" "Java / Spring Boot"

            # Internal relationships (inside OPS)
            customer -> orderApi "Places orders / queries status" "HTTPS"
            orderApi -> orderService "Invokes domain operations"
            orderService -> orderDb "Reads/Writes order state" "JDBC"
            orderService -> integrationService "Triggers external operations"

        }

        # External Systems
        paymentSystem = softwareSystem "Payment System" "Executes transactions" {
            tags "External"
        }

        inventorySystem = softwareSystem "Inventory System" "Tracks product availability" {
            tags "External"
        }

        notificationSystem = softwareSystem "Notification System" "Sends notifications to customers" {
            tags "External"
        }

        accountingSystem = softwareSystem "Accounting System" "Financial reporting & compliance" {
            tags "External"
        }

        # CONTEXT-LEVEL RELATIONSHIPS (high-level intention, no mechanism)
        customer -> ops "Creates and tracks orders"
        ops -> paymentSystem "Processes payments"
        ops -> inventorySystem "Checks availability"
        ops -> notificationSystem "Sends events"
        ops -> accountingSystem "Reports transactions"

        # CONTAINER-LEVEL INTEGRATION RELATIONSHIPS (implementation details)
        integrationService -> paymentSystem "Requests payments" "HTTPS"
        integrationService -> inventorySystem "Validates availability" "HTTPS"
        integrationService -> notificationSystem "Sends order notifications" "HTTPS"
        integrationService -> accountingSystem "Submits reporting data" "HTTPS"
    }



    views {

        # ============================
        # CONTEXT VIEW
        # ============================

        systemContext ops {
            include *
            exclude orderApi
            exclude orderService
            exclude orderDb
            exclude integrationService
            autolayout lr
        }

        # ============================
        # CONTAINER VIEW
        # ============================

        container ops {
            include *
            autolayout lr
        }

        # ============================
        # STYLES
        # ============================

        styles {
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }

            element "Software System" {
                background #1168bd
                color #ffffff
            }

            element "Container" {
                background #438dd5
                color #ffffff
            }

            element "External" {
                background #999999
                color #ffffff
            }
        }
    }
    # Link your markdown folder
    !docs docs
    # Hide the default ADR rendering & introduce the arc42 structure that we follow
    # !adrs docs/adr
}
