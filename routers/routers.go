package routers

import (
	"github.com/gin-gonic/gin"
	"github.com/wisedevguy/fp-sanbercode-golang-batch-41-v2/controllers"
	"github.com/wisedevguy/fp-sanbercode-golang-batch-41-v2/middleware"
)

func StartServer() *gin.Engine {
	router := gin.Default()

	public := router.Group("/api/v1")

	public.POST("/register", controllers.Register)
	public.POST("/login", controllers.Login)

	public.Use(middleware.Authentication())
	{
		// ROUTERS FOR AUTH LOGOUT
		public.POST("/logout", controllers.Logout)
		public.GET("/admins", controllers.GetAllAdmin)

		// ROUTERS FOR PATIENTS
		public.GET("/patients", controllers.GetAllPatients)
		public.GET("/patients/:id", controllers.GetPatientByID)
		public.POST("/patients", controllers.InsertPatient)
		public.PUT("/patients/:id", controllers.UpdatePatient)
		public.DELETE("/patients/:id", controllers.DeletePatient)

		// ROUTERS FOR DOCTORS
		public.GET("/doctors", controllers.GetAllDoctors)
		public.GET("/doctors/:id", controllers.GetDoctorByID)
		public.POST("/doctors", controllers.InsertDoctor)
		public.PUT("/doctors/:id", controllers.UpdateDoctor)
		public.DELETE("/doctors/:id", controllers.DeleteDoctor)

		// ROUTERS FOR DEPARTEMENTS
		public.GET("/departements", controllers.GetAllDepartements)
		public.GET("/departements/:id", controllers.GetDepartementByID)
		public.POST("/departements", controllers.InsertDepartement)
		public.PUT("/departements/:id", controllers.UpdateDepartement)
		public.DELETE("/departements/:id", controllers.DeleteDepartement)

		// ROUTERS FOR APPOINTMENTS
		public.GET("/appointments", controllers.GetAllAppointments)
		public.GET("/appointments/:id", controllers.GetAppointmentByID)
		public.POST("/appointments", controllers.InsertAppointment)
		public.PUT("/appointments/:id", controllers.UpdateAppointment)
		public.DELETE("/appointments/:id", controllers.DeleteAppointment)
	}

	return router
}
