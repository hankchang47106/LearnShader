using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEngine.ProBuilder;

public class RiverMaker : MonoBehaviour
{
    public List<RiverMakerNode> controlPointList;
    [HideInInspector] [SerializeField] GameObject controlPoints;
    [SerializeField] private MeshFilter riverMeshFilter;
    [SerializeField] private Mesh riverMesh;

    public Material quadMaterial;


    void Start()
    {
        foreach (Transform child in transform)
        {
            if (child.name != "Control Points")
            {
                child.SetParent(null);
            }
        }
        Destroy(gameObject); //Check if later LTS version correct the bug https://forum.unity.com/threads/case-1426900-error-destroy-may-not-be-called-from-edit-mode-is-shown-when-stopping-play.1279895/
    }


    public void DrawRiver()
    {
        if (controlPointList == null || controlPointList.Count < 2)
        {
            if (riverMeshFilter != null)
                riverMeshFilter.mesh = null;
            return;
        }

        int n = controlPointList.Count;
        Vector3[] vertices = new Vector3[2 * n];
        Vector2[] uv = new Vector2[2 * n];
        int[] triangles = new int[6 * (n - 1)];

        for (int i = 0; i < n; i++)
        {
            RiverMakerNode rmNode = controlPointList[i];
            vertices[2 * i] = rmNode.transform.position + rmNode.RiverWidth * rmNode.transform.right;
            vertices[2 * i + 1] = rmNode.transform.position - rmNode.RiverWidth * rmNode.transform.right;
        }

        float h = 1 / (n - 1);
        for (int i = 0; i < n - 1; i++)
        {
            uv[2 * i] = new(0, i * h);
            uv[2 * i + 1] = new(1, i * h);

            int j = 6 * i;
            int k = 2 * i;
            triangles[j + 0] = k + 0;
            triangles[j + 1] = k + 1;
            triangles[j + 2] = k + 3;

            triangles[j + 3] = k + 0;
            triangles[j + 4] = k + 3;
            triangles[j + 5] = k + 2;
        }

        riverMesh = new Mesh();
        riverMesh.vertices = vertices;
        riverMesh.uv = uv;
        riverMesh.triangles = triangles;

        transform.Find("River").GetComponent<MeshFilter>().mesh = riverMesh;
    }

    [MenuItem("GameObject/Custom/RiverMaker", false, 10)]
    static void CreateRiverMaker(MenuCommand menuCommand)
    {
        GameObject riverMakerGO = new("River Maker");
        GameObjectUtility.SetParentAndAlign(riverMakerGO, menuCommand.context as GameObject);
        Undo.RegisterCreatedObjectUndo(riverMakerGO, "Create " + riverMakerGO.name);
        Selection.activeObject = riverMakerGO;

        RiverMaker riverMaker = riverMakerGO.AddComponent<RiverMaker>();
        riverMaker.controlPoints = new("Control Points");
        riverMaker.controlPoints.transform.SetParent(riverMakerGO.transform);
        riverMaker.controlPointList = new();


        riverMaker.controlPointList = new();
        riverMaker.controlPointList.Add(riverMaker.CreateFirstNode().GetComponent<RiverMakerNode>());

        if (riverMaker.transform.Find("River") == null)
            riverMaker.CreateRiver();
    }

    private void CreateRiver()
    {
        GameObject river = new("River", typeof(MeshFilter), typeof(MeshRenderer));
        river.transform.SetParent(transform);
        riverMeshFilter = river.GetComponent<MeshFilter>();
    }

    private GameObject CreateFirstNode()
    {
        GameObject firstNode = new("Control Node");
        firstNode.transform.SetParent(controlPoints.transform);
        firstNode.AddComponent<RiverMakerNode>();
        return firstNode;
    }
}