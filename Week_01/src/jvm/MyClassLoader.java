package jvm;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class MyClassLoader extends ClassLoader {

    public static void main(String[] args) {
        try {
            MyClassLoader myClassLoader = new MyClassLoader();
            Class<?> clazz = myClassLoader.findClass("Hello");
            Object obj = clazz.newInstance();
            Method method = clazz.getMethod("hello");
            method.invoke(obj);
        } catch (IllegalAccessException | InstantiationException | ClassNotFoundException | NoSuchMethodException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected Class<?> findClass(String name) throws ClassNotFoundException {
        String filePath = "E:\\Documents\\Learning\\Hello.xlass";
        Class clazz = null;
        byte[] classBytes = null;

        InputStream inputStream = null;

        try {
            File file = new File(filePath);
            inputStream = new FileInputStream(file);
            int num = inputStream.available();
            classBytes = new byte[num];
            inputStream.read(classBytes);
            for (int i = 0; i < num; i++) {
                classBytes[i] = (byte) (255 - classBytes[i]);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        clazz = defineClass(name, classBytes, 0, classBytes.length);
        return clazz;
    }
}
