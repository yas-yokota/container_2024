package main

import (
  "encoding/json"
  "fmt"
  "log"
  "net/http"
  "os"
  "strings"
  "time"
)

type oData struct {
	InputLine string `json:"input"`
	OutputLine string `json:"output"`
}

func main() {
    logStd("serverStartup")
    http.HandleFunc("/word/", itemsIdHandler) 
    if err := http.ListenAndServe(":8081", nil); err != nil {
        log.Fatal("__FATAL__:", err)
    }
}

func itemsIdHandler(w http.ResponseWriter, r *http.Request) {
    var odata = oData{}

    params := strings.TrimPrefix(r.URL.Path, "/word/")
    odata.InputLine = params
    odata.OutputLine = strings.ToUpper(params)
    outputJson, err := json.Marshal(&odata)
    if err != nil {
        panic(err)
    }
    //fmt.Fprintf(w, strings.ToUpper(params))
    w.Header().Set("Content-Type","application/json")
    logStd("param=" + "\"" + params + "\"" )
    fmt.Fprint(w, string(outputJson))
}

func logStd(msg string) {
    const MilliFormat = "2006/01/02 15:04:05.000"
    nowTime := time.Now()
    logline := fmt.Sprintf("%s\tmygoserver\tBODY:%s\n", nowTime.Format(MilliFormat), msg)
    _, _ = os.Stderr.Write([]byte(logline))

}
