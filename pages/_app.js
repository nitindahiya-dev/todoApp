import { TodoListProvider } from "../context/ToDolistApp";
import "../styles/globals.css";

const MyApp = ({ Component, pageProps }) => {
  <TodoListProvider>
    <div className="">
      <Component {...pageProps} />
    </div>
  </TodoListProvider>;
};

export default MyApp;
