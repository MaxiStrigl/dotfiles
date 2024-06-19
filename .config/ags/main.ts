import Bar from 'widget/Bar/bar'
import Gtk from "gi://Gtk?version=3.0"
import Gdk from "gi://Gdk"


function forAllMonitors(widget: (monitor: number) => Gtk.Window) {
    const n :number = Gdk.Display.get_default()?.get_n_monitors() || 1
    return range(n, 0).flatMap(widget)
}

function range(length: number, start = 1) {
    return Array.from({ length }, (_, i) => i + start)
}


const scss = "./style.scss"
const css = `/tmp/my-style.css`
Utils.exec(`sassc ${scss} ${css}`)

App.config({
    style: css,
    windows: () =>  
    [
      ...forAllMonitors(Bar),
    ],
})
