#include <stdio.h>
#include <math.h>
#define MIN_DOUBLE 0.00001
#define MIN_DOUBLE_NEGATIVE -0.00001



int main()
{
    int n;
    scanf("%d", &n);

    float matrix[n][n + 1];

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n + 1; j++)
        {
            scanf("%f", &matrix[i][j]);
        }
    }

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (matrix[i][j] != 0)
            {
                double divider = matrix[i][j];
                for (int k = 0; k < n + 1; k++)
                {
                    matrix[i][k] /= divider;
                }
                
                for (int k = 0; k < n; k++)
                {
                    if (k == i)
                    {
                        continue;
                    }
                    double coeficcient = matrix[k][j];
                    for (int s = 0; s < n + 1; s++)
                    {
                        matrix[k][s] -= matrix[i][s] * coeficcient;
                    }
                }
                break;
            }
        }
    }

    for (int i = 0; i < n; i++)
    {
        int flag = 1;
        for (int j = 0; j < n; j++)
        {
            if (matrix[i][j] != 0)
            {
                flag = 0;
                break;
            }
        }
        if (flag)
        {
            printf("Impossible\n");
            return 0;
        }
    }

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (matrix[j][i] != 0)
            {
                printf("%.2f ", matrix[j][n]);
                break;
            }
        }
    }
}