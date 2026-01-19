workspace "Order Processing System" "C4 model for the Order Processing System demo" {

    model {
        # ============================
        # PEOPLE
        # ============================

        customer = person "Customer" "Places and tracks orders"

        # ============================
        # SOFTWARE SYSTEM
        # ============================

        ops = softwareSystem "Order Processing System" "Manages the lifecycle of customer orders" {

            # ============================
            # CONTAINERS
            # ============================

            orderApi = container "Order API" "Exposes the public HTTP API for order operations" "REST API / Spring Boot"
            orderService = container "Order Service" "Implements order workflows and core business logic" "Java / Spring Boot"
            orderDb = container "Order Database" "Stores orders, order state, and audit trail" "PostgreSQL" {
              tags "Database"
            }
            integrationService = container "Integration Service" "Outbound gateway and anti-corruption layer for external systems" "Java / Spring Boot"

            # ============================
            # INTERNAL CONTAINER RELATIONSHIPS
            # ============================

            orderApi -> orderService "Invokes domain operations"
            orderService -> orderDb "Reads and writes order state" "JDBC"
            orderService -> integrationService "Triggers external operations"
        }

        # ============================
        # EXTERNAL SYSTEMS
        # ============================

        paymentSystem = softwareSystem "Payment System" "Executes financial transactions" {
            tags "External"
        }

        inventorySystem = softwareSystem "Inventory System" "Tracks product availability" {
            tags "External"
        }

        notificationSystem = softwareSystem "Notification System" "Sends notifications to customers" {
            tags "External"
        }

        accountingSystem = softwareSystem "Accounting System" "Financial reporting and compliance" {
            tags "External"
        }

        # ============================
        # CONTEXT-LEVEL RELATIONSHIPS
        # ============================

        customer -> ops "Creates and tracks orders"

        ops -> paymentSystem "Processes payments"
        ops -> inventorySystem "Checks product availability"
        ops -> notificationSystem "Publishes order-related events"
        ops -> accountingSystem "Reports financial transactions"

        # ============================
        # CONTAINER-LEVEL INTEGRATION RELATIONSHIPS
        # ============================

        integrationService -> paymentSystem "Requests payments" "HTTPS"
        integrationService -> inventorySystem "Validates availability" "HTTPS"
        integrationService -> notificationSystem "Sends order notifications" "HTTPS"
        integrationService -> accountingSystem "Submits accounting data" "HTTPS"
    }

    views {
        # ============================
        # SYSTEM CONTEXT VIEW
        # ============================

        systemContext ops "SystemContext" "Shows the Order Processing System and its external actors and systems" {
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

        container ops "Containers" "Shows the main containers of the Order Processing System and their interactions" {
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

            element "SoftwareSystem" {
                background #1168bd
                color #ffffff
            }

            element "Container" {
                shape roundedbox
                background #438dd5
                color #ffffff
            }

            element "Database" {
                shape cylinder
                background #438dd5
                color #ffffff
            }

            element "External" {
                background #999999
                color #ffffff
            }
        }
    }

    # ============================
    # DOCUMENTATION INTEGRATION
    # ============================

    # Render your documentation stored as markdown files
    !docs docs
}
