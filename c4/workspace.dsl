workspace "Order Processing System" "C4 model for the Order Processing System demo" {

    model {
        customer = person "Customer" "Places and tracks orders"

        ops = softwareSystem "Order Processing System" "Manages the lifecycle of customer orders"

        paymentSystem = softwareSystem "Payment System" "Handles payment execution" {
            tags "External"
        }

        inventorySystem = softwareSystem "Inventory System" "Manages product availability" {
            tags "External"
        }

        notificationSystem = softwareSystem "Notification System" "Sends notifications" {
            tags "External"
        }

        accountingSystem = softwareSystem "Accounting System" "Financial reporting system" {
            tags "External"
        }

        customer -> ops "Creates and tracks orders"
        ops -> paymentSystem "Requests payment"
        ops -> inventorySystem "Checks availability"
        ops -> notificationSystem "Sends order events"
        ops -> accountingSystem "Reports order data"
    }

    views {
        systemContext ops {
            include *
            autolayout lr
        }

        container ops {
            include *
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

            element "External" {
                background #999999
                color #ffffff
            }
        }
    }
}
