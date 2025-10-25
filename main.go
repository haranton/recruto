package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		name := c.DefaultQuery("name", "Recruto")
		message := c.DefaultQuery("message", "Давай дружить!")

		response := "Hello " + name + "! " + message
		c.String(http.StatusOK, response)
	})

	r.Run(":8080")
}
