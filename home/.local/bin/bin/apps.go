package main

import (
	"log"
	"os/exec"
	"sync"
)

type WorkspaceApp struct {
	Workspace int
	App       string
}

// Función para cambiar workspace y lanzar app en paralelo
func launchApp(wsApp WorkspaceApp, wg *sync.WaitGroup) {
	defer wg.Done()

	// Cambiar al workspace correspondiente
	err := exec.Command("hyprctl", "dispatch", "workspace", string(wsApp.Workspace+'0')).Run()
	if err != nil {
		log.Printf("Error cambiando al workspace %d: %v\n", wsApp.Workspace, err)
		return
	}

	// Lanzar la app en background inmediatamente
	cmd := exec.Command("sh", "-c", wsApp.App)
	if err := cmd.Start(); err != nil {
		log.Printf("Error lanzando %s en workspace %d: %v\n", wsApp.App, wsApp.Workspace, err)
		return
	}

	log.Printf("Lanzada %s en workspace %d\n", wsApp.App, wsApp.Workspace)
}

func main() {
	// Lista de apps y workspaces según tu configuración
	apps := []WorkspaceApp{
		{Workspace: 1, App: "kitty"},
		{Workspace: 2, App: "opera"},
		{Workspace: 3, App: "telegram-desktop"},
		{Workspace: 4, App: "keepassxc"},
	}

	var wg sync.WaitGroup

	// Lanzar todas las apps en paralelo
	for _, wsApp := range apps {
		wg.Add(1)
		go launchApp(wsApp, &wg)
	}

	// Esperar a que todas terminen de lanzarse
	wg.Wait()

	// Volver al workspace 1 como default al final
	exec.Command("hyprctl", "dispatch", "workspace", "1").Run()

	log.Println("Todas las aplicaciones fueron lanzadas en paralelo y workspace 1 activo.")
}

