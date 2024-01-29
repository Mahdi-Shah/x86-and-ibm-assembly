#include <stdio.h>
#define LIMIT 100

void print_array(short arr[], int len, int flag)
{
    if (len == 1 && arr[0] == 0)
        flag = 1;
    if (flag == -1)
        printf("-");
    for (int i = 0; i < len; i++) {
        printf("%d", arr[i]);
    }
    printf("\n");
}

void reverse_array(short number[], int len)
{
    short temp;
    for (int i = 0; i < len / 2; i++)
    {
        temp = number[i];
        number[i] = number[len - i - 1];
        number[len - i - 1] = temp;
    }
}

void get_number(short number[], int* flag, int* len)
{
    char ch;
    int i;
    for (i = 0; i < LIMIT; i++)
        number[i] = 0;

    for (i = 0; (ch = getchar()) != ' ' && ch != '\n'; i++)
    {
        if (ch == '-')
        {
            (*flag) = -1;
            i--;
            continue;
        }
        number[i] = (short)(((int) ch) - 48);
    }
    *len = i;
    
    reverse_array(number, *len);
}

void first_input_is_bigger(short first_number[], int first_number_flag, int first_number_len,
            short second_number[], int second_number_flag, int second_number_len,
            short bigger_number[], int* bigger_number_flag, int* bigger_number_len, 
            short smaller_number[], int* smaller_number_flag, int* smaller_number_len)
{
    *bigger_number_len = first_number_len;
    *bigger_number_flag = first_number_flag;
    *smaller_number_len = second_number_len;
    *smaller_number_flag = second_number_flag;
    for (int i = 0; i < first_number_len; i++)
        bigger_number[i] = first_number[i];
    for (int i = 0; i < second_number_len; i++)
        smaller_number[i] = second_number[i];

    return;
    
}

void set_small_and_big_number(short first_number[], int first_number_flag, int first_number_len,
            short second_number[], int second_number_flag, int second_number_len,
            short bigger_number[], int* bigger_number_flag, int* bigger_number_len, 
            short smaller_number[], int* smaller_number_flag, int* smaller_number_len)
{
    if (first_number_len > second_number_len)
    {
        first_input_is_bigger(first_number, first_number_flag, first_number_len, 
                                second_number, second_number_flag, second_number_len,
                                bigger_number, bigger_number_flag, bigger_number_len, 
                                smaller_number, smaller_number_flag, smaller_number_len);
        return;
    }
    if (second_number_len > first_number_len)
    {
        first_input_is_bigger(second_number, second_number_flag, second_number_len,
                                first_number, first_number_flag, first_number_len, 
                                bigger_number, bigger_number_flag, bigger_number_len, 
                                smaller_number, smaller_number_flag, smaller_number_len);
        return;
    }
    for (int i = 0; i < first_number_len; i++)
    {
        if (first_number[first_number_len - i - 1] > second_number[first_number_len - i -1])
        {
            first_input_is_bigger(first_number, first_number_flag, first_number_len, 
                                second_number, second_number_flag, second_number_len,
                                bigger_number, bigger_number_flag, bigger_number_len, 
                                smaller_number, smaller_number_flag, smaller_number_len);
            return;
        }
        if (first_number[first_number_len - i - 1] < second_number[first_number_len - i -1])
        {
            first_input_is_bigger(second_number, second_number_flag, second_number_len,
                                first_number, first_number_flag, first_number_len, 
                                bigger_number, bigger_number_flag, bigger_number_len, 
                                smaller_number, smaller_number_flag, smaller_number_len);
        return;
        }
    }
    first_input_is_bigger(second_number, second_number_flag, second_number_len,
                                first_number, first_number_flag, first_number_len, 
                                bigger_number, bigger_number_flag, bigger_number_len, 
                                smaller_number, smaller_number_flag, smaller_number_len);
}

void normalize_array(short arr[], int* len)
{
    for (int i = 0; i < *len; i++)
    {
        while(arr[i] < 0)
        {
            arr[i] += 10;
            arr[i + 1] -= 1;
        }
        while(arr[i] >= 10)
        {
            arr[i] -= 10;
            arr[i + 1] += 1;
            if (i == *len - 1 && arr[i] < 10)
                *len = *len + 1;
        }
    }
    for (int i = *len - 1; i > 0; i--)
    {
        if(arr[i] == 0)
            *len = *len - 1;
        else
            break;
    }
}

void subtract_first_element_from_second(short first_number[], int* first_number_len,
                                        short second_number[], int second_number_len, int from)
{
    for (int i = 0; i < second_number_len; i++)
    {
        first_number[i + from] -= second_number[i];
    }

    normalize_array(first_number, first_number_len);
}

void add(short first_number[], int first_number_flag, int first_number_len,
            short second_number[], int second_number_flag, int second_number_len)
{
    short output[LIMIT];
    int output_len;
    short bigger_number[LIMIT];
    int bigger_number_len;
    int bigger_number_flag;
    short smaller_number[LIMIT];
    int smaller_number_len;
    int smaller_number_flag;
    int* bigger_number_len_ptr = &bigger_number_len;
    int* smaller_number_len_ptr = &smaller_number_len;
    int* bigger_number_flag_ptr = &bigger_number_flag;
    int* smaller_number_flag_ptr = &smaller_number_flag;
    set_small_and_big_number(first_number, first_number_flag, first_number_len,
                    second_number, second_number_flag, second_number_len, 
                    bigger_number, bigger_number_flag_ptr, bigger_number_len_ptr,
                    smaller_number, smaller_number_flag_ptr, smaller_number_len_ptr);
    output_len = bigger_number_len;
    int* output_len_ptr = &output_len;
    output[bigger_number_len] = 0;
    if (first_number_flag == second_number_flag)
    {
        for (int i = 0; i < bigger_number_len; i++)
        {
            output[i] = bigger_number[i];
        }
        for (int i = 0; i < smaller_number_len; i++)
        {
            output[i] += smaller_number[i];
        }
        normalize_array(output, output_len_ptr);
        reverse_array(output, output_len);
        print_array(output, output_len, first_number_flag);
    }
    else
    {
        subtract_first_element_from_second(bigger_number, bigger_number_len_ptr, smaller_number, smaller_number_len, 0);
        reverse_array(bigger_number, bigger_number_len);
        print_array(bigger_number, bigger_number_len, bigger_number_flag);
    }

}

void subtract(short first_number[], int first_number_flag, int first_number_len,
            short second_number[], int second_number_flag, int second_number_len)
{
    add(first_number, first_number_flag, first_number_len, 
                    second_number, -1 * second_number_flag, second_number_len);
}

void multiple(short first_number[], int first_number_flag, int first_number_len,
            short second_number[], int second_number_flag, int second_number_len)
{
    short output[LIMIT];
    int output_len = first_number_len + second_number_len + 1;
    int* output_len_ptr = &output_len;
    for(int i = 0; i < LIMIT; i++)
        output[i] = 0;
    for(int i = 0; i < first_number_len; i++)
    {
        for(int j = 0; j < second_number_len; j++)
        {
            output[i + j] += first_number[i] * second_number[j];
        }
    }
    normalize_array(output, output_len_ptr);
    reverse_array(output, output_len);
    print_array(output, output_len, first_number_flag * second_number_flag);
}

void divide(short first_number[], int first_number_flag, int first_number_len,
            short second_number[], int second_number_flag, int second_number_len)
{
    short output[LIMIT];
    for (int i = 0; i < LIMIT; i++)
        output[i] = 0;
    int* first_number_len_ptr = &first_number_len;
    while (first_number_len > second_number_len)
    {
        output[first_number_len - second_number_len - 1] += 1;
        subtract_first_element_from_second(first_number, first_number_len_ptr,
                        second_number, second_number_len, first_number_len - second_number_len - 1);
    }

    while (first_number[second_number_len - 1] > second_number[second_number_len - 1])
    {
        output[first_number_len - second_number_len] += 1;
        subtract_first_element_from_second(first_number, first_number_len_ptr,
                        second_number, second_number_len, 0);
    }
    
    output[0] += 1;
    for (int i = second_number_len - 1; i > -1; i--)
    {
        if (second_number[i] > first_number[i])
        {
            output[0] -= 1;
            break;
        }
        if (first_number[i] > second_number[i])
            break;
    }
    int i;
    for (i = LIMIT; i > 0; i--)
    {
        if(output[i] > 0)
            break;
    }
    int output_len = i + 1;
    int* output_len_ptr = &output_len;
    normalize_array(output, output_len_ptr);
    reverse_array(output, output_len);
    print_array(output, output_len, first_number_flag * second_number_flag);  
}


int main()
{
    char ch;

    while ((ch = getchar()) != 'q')
    {
        short first_number[LIMIT];
        int first_number_flag = 1;
        int first_number_len;
        short second_number[LIMIT];
        int second_number_flag = 1;
        int second_number_len;
        int* first_number_flag_ptr = &first_number_flag;
        int* first_number_len_ptr = &first_number_len;
        int* second_number_flag_ptr = &second_number_flag;
        int* second_number_len_ptr = &second_number_len;
        getchar();

        get_number(first_number, first_number_flag_ptr, first_number_len_ptr);
        get_number(second_number, second_number_flag_ptr, second_number_len_ptr);


        if (ch == '+')
            add(first_number, first_number_flag, first_number_len, 
                    second_number, second_number_flag, second_number_len);
        else if (ch == '-')
            subtract(first_number, first_number_flag, first_number_len, 
                    second_number, second_number_flag, second_number_len);
        else if (ch == 'x')
            multiple(first_number, first_number_flag, first_number_len, 
                    second_number, second_number_flag, second_number_len);
        else if (ch == '/')
            divide(first_number, first_number_flag, first_number_len, 
                    second_number, second_number_flag, second_number_len);
    }
    
}
