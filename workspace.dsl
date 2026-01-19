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
            orderService = container "Order Service" "Implements order workflows and core business logic" "Java / Spring Boot"
            orderDb = container "Order Database" "Stores orders, order state, and audit trail" "PostgreSQL" {
                tags "Database"
            }
            integrationService = container "Integration Service" "Outbound gateway and anti-corruption layer for external systems" "Java / Spring Boot"

            # ============================
            # INTERNAL CONTAINER RELATIONSHIPS
            # ============================
            orderService -> orderDb "Reads and writes order state" "JDBC"
            orderService -> integrationService "Triggers external operations"

            # REQUIRED LOGICAL RELATIONSHIP: Customer to Service
            customer -> orderService "Uses OPS via ALB" "HTTPS"
        }

        # ============================
        # EXTERNAL SYSTEMS
        # ============================
        paymentSystem = softwareSystem "Payment System" "Executes transactions" {
          tags "External"
        }
        inventorySystem = softwareSystem "Inventory System" "Tracks availability" {
          tags "External"
        }
        notificationSystem = softwareSystem "Notification System" "Sends alerts" {
          tags "External"
        }
        accountingSystem = softwareSystem "Accounting System" "Financial reporting" {
          tags "External"
        }

        # ============================
        # CONTEXT-LEVEL RELATIONSHIPS
        # ============================
        customer -> ops "Creates and tracks orders"
        ops -> paymentSystem "Processes payments"
        ops -> inventorySystem "Checks product availability"
        ops -> notificationSystem "Publishes events"
        ops -> accountingSystem "Reports transactions"

        # ============================
        # CONTAINER-LEVEL INTEGRATION RELATIONSHIPS
        # ============================
        integrationService -> paymentSystem "Requests payments" "HTTPS"
        integrationService -> inventorySystem "Validates availability" "HTTPS"
        integrationService -> notificationSystem "Sends order notifications" "HTTPS"
        integrationService -> accountingSystem "Submits accounting data" "HTTPS"

        # ============================
        # DEPLOYMENT MODEL
        # ============================
        aws = deploymentEnvironment "AWS" {
            vpc = deploymentNode "VPC" "Isolated network" {

                alb = infrastructureNode "Application Load Balancer" "Public entry point for HTTP traffic" "AWS ALB" {
                    tags "Infrastructure"
                }

                ecs = deploymentNode "ECS Cluster (Fargate)" "Runs the Order Service" {
                    orderServiceInstance = containerInstance orderService
                }

                rds = deploymentNode "RDS PostgreSQL" "Managed database" {
                    containerInstance orderDb
                }

                # PERMITTED DEPLOYMENT RELATIONSHIP: Infrastructure to Instance
                alb -> orderServiceInstance "Forwards requests" "HTTPS"
            }
            # Note: Do NOT add customer -> alb here. It is not permitted in DSL.
            # Structurizr will draw customer -> alb -> orderServiceInstance automatically
            # based on the logical relationship above.
        }
    }

    views {
        # ============================
        # SYSTEM CONTEXT VIEW
        # ============================
        systemContext ops "SystemContext" "Context Diagram" {
            include *
            exclude orderService orderDb integrationService
            autolayout lr
        }

        # ============================
        # CONTAINER VIEW
        # ============================
        container ops "Containers" "Container Diagram" {
            include *
            autolayout lr
        }

        # ============================
        # DEPLOYMENT VIEW
        # ============================
        deployment ops "AWS" "DeploymentView" "Infrastructure Diagram" {
            include *
            autolayout lr
        }

        # ============================
        # DYNAMIC VIEW – PLACE ORDER
        # ============================

        dynamic ops "PlaceOrder" "Runtime Workflow Diagram – Place Order (Happy Path)" {
            # Added sequence numbers to match the diagram exactly
            customer -> orderService "Calls createOrder(dto)"

            orderService -> integrationService "inventoryService.checkAvailability(request)"
            integrationService -> inventorySystem "GET /availability [HTTPS]"
            inventorySystem -> integrationService "HTTP 200: Available [HTTPS]"
            integrationService -> orderService "Availability confirmed"

            # The first DB save, starting from OrderService
            orderService -> orderDb "orderRepository.save(order) [Status: CREATED]"

            orderService -> integrationService "paymentService.authorizePayment(request)"
            integrationService -> paymentSystem "POST /authorize [HTTPS]"
            paymentSystem -> integrationService "HTTP 200: AUTHORIZED [HTTPS]"
            integrationService -> orderService "PaymentResult: AUTHORIZED"

            # The second DB save, starting from OrderService
            orderService -> orderDb "orderRepository.save(order) [Status: CONFIRMED]"

            orderService -> integrationService "notificationService.send(notification)"
            integrationService -> notificationSystem "Sends Email/SMS"

            orderService -> integrationService "accountingService.report(record)"
            integrationService -> accountingSystem "POST /report"

            orderService -> customer "Returns UUID orderId"

            autolayout lr
        }

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
              shape roundedbox
              background #438dd5
              color #ffffff
            }
            element "Database" {
              shape cylinder
              background #438dd5
              color #ffffff
            }
            element "Infrastructure" {
              background #999999
              color #ffffff
              shape roundedbox
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
