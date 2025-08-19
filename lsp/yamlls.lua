return {
    settings = {
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
        yaml = {
            schemas = {
                ["https://directory.omsf.io/schema.json"] = {
                    "/software/*",
                    "/workflows/*",
                    "/software/**/*",
                    "/workflows/**/*",
                },
            },
        },
    },
}
