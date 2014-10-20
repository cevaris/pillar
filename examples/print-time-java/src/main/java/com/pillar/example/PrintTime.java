package com.pillar.example;

import java.util.Map;
import java.util.logging.Logger;
import java.util.logging.FileHandler;
import java.lang.management.ManagementFactory;

class PrintTime {

    private FileHandler logHandler;
    private final static Logger LOGGER = Logger.getLogger(PrintTime.class.getName()); 
    private Map<String, String> env = System.getenv();

    public PrintTime(){

    
        ////////////////////////////////////////////////////
        // Pid file creation
        String pid = this.getPID().toString();

        // Setup logging
        try{
            logHandler = new FileHandler("/tmp/print-time.log");
        } catch (java.io.IOException e){}
        LOGGER.addHandler(logHandler);
        Runtime.getRuntime().addShutdownHook(new Thread(){
            public void run() {
                logHandler.close();
            }
        });


        ////////////////////////////////////////////////////
        // Actual Worker Code

        if(env.containsKey("MY_ENV")){
            System.out.println(String.format("java %s", env.get("MY_ENV")));
        }

        while(true){
            Long epoch = System.currentTimeMillis()/1000;

            LOGGER.info(String.format("Checkin: %s %s", pid, epoch.toString()));
            try{
                Thread.sleep(5000);
            } catch (java.lang.InterruptedException e) {
            }
        }
        
    }

    public Long getPID() {
        String processName = ManagementFactory.getRuntimeMXBean().getName();
        return Long.parseLong(processName.split("@")[0]);
    }

    public static void main(String[] args) {

        // Execute Code
        new PrintTime();

    }

}