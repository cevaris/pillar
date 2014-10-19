import java.util.Map;

class PrintTime {

    private Map<String, String> env = System.getenv();

    public PrintTime(){
        if(env.containsKey("MY_ENV")){
            System.out.println(String.format("java %s", env.get("MY_ENV")));
        }
    }

    public static void main(String[] args) {
        new PrintTime();
    }

}